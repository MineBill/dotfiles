import System.Exit
import Control.Monad (forM_, join, when)

import Data.Monoid
import Data.List (sortBy)
import Data.Function (on)
import Data.Maybe (maybeToList)

import XMonad
import XMonad.Config.Desktop

import XMonad.Util.Run (safeSpawn)
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.NamedScratchpad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ServerMode
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.Spacing

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

gray      = "#7F7F7F"
gray2     = "#222222"
red       = "#900000"
blue      = "#2E9AFE"
white     = "#eeeeee"

myTerminal      = "kitty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myBorderWidth   = 3

myModMask       = mod1Mask

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm , xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_c     ), spawn "CM_LAUNCHER=rofi clipmenu -theme custom")
    , ((modm,               xK_p     ), spawn "rofi -show drun -theme custom -icon-theme \"Numix\" -show-icons")
    , ((modm,               xK_q     ), spawn "qutebrowser")
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    , ((modm .|. shiftMask, xK_p     ), spawn "~/scripts/get_passwd.sh")
    , ((modm .|. shiftMask, xK_q     ), kill)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_Delete), io (exitWith ExitSuccess))

    , ((modm .|. controlMask .|. shiftMask, xK_m), namedScratchpadAction scratchpads "ncmpcpp")
    , ((modm .|. controlMask .|. shiftMask, xK_n), namedScratchpadAction scratchpads "newsboat")
    , ((modm .|. controlMask .|. shiftMask, xK_b), namedScratchpadAction scratchpads "btm")

    , ((0, xK_Print), spawn "flameshot gui")

    --, ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_e     ), spawn "~/scripts/exit_i3.sh")

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- Not really interested in this for now
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        -- , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

scratchpads = 
    [ NS "ncmpcpp"  spawnNcmpcpp  findNcmpcpp  manageNcmpcpp
    , NS "btm"      spawnBtm      findBtm      manageBtm
    , NS "newsboat" spawnNewsboat findNewsboat manageNewsboat
    ]
    where
        spawnNcmpcpp  = myTerminal ++ " --class ncmpcpp ncmpcpp"
        findNcmpcpp   = className =? "ncmpcpp"
        manageNcmpcpp = customFloating $ W.RationalRect l t w h
                        where
                            h = 0.9
                            w = 0.9
                            t = 0.95 - h
                            l = 0.95 - w
        spawnBtm  = myTerminal ++ " --class btm btm"
        findBtm   = className =? "btm"
        manageBtm = customFloating $ W.RationalRect l t w h
                        where
                            h = 0.9
                            w = 0.9
                            t = 0.95 - h
                            l = 0.95 - w
        spawnNewsboat  = myTerminal ++ " --class newsboat newsboat"
        findNewsboat   = className =? "newsboat"
        manageNewsboat = customFloating $ W.RationalRect l t w h
                        where
                            h = 0.9
                            w = 0.9
                            t = 0.95 - h
                            l = 0.95 - w

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayoutHook = spacingRaw True (Border 0 0 0 0) False (Border  5 5 5 5) True $ avoidStruts (tiled ||| Full)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "discord"                   --> doShift "8"
    , className =? "Microsoft Teams - Preview" --> doShift "7"
    , resource  =? "desktop_window"            --> doIgnore
    , resource  =? "kdesktop"                  --> doIgnore
    --, isFullscreen --> doFullFloat
    , manageDocks ]

------------------------------------------------------------------------
-- Event handling
--myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
myLogHook :: D.Client -> PP
myLogHook dbus = def 
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{F" ++ blue ++ "} ") " %{F-}"
    , ppVisible = wrap ("%{F" ++ gray ++ "} ") " %{F-}"
    , ppUrgent = wrap ("%{F" ++ red ++ "} ") " %{F-}"
    , ppHidden = wrap ("%{F" ++ gray ++ "} ") " %{F-}"
    , ppTitle = wrap ("%{F" ++ gray2 ++ "} ") " %{F-}"
    }

myDynamicLogHook dbus = do
    dynamicLogWithPP (myLogHook dbus)

    winset <- gets windowset
    title <- maybe (return "") (fmap show . getName) . W.peek $ winset
    let currWs = W.currentTag winset
    let wss = map W.tag $ W.workspaces winset
    let wsStr = join $ map (fmt currWs) $ sort' wss

    io $ appendFile "/tmp/.xmonad-title-log" (title ++ "\n")
    io $ appendFile "/tmp/.xmonad-workspace-log" (wsStr ++ "\n")

    where fmt currWs ws
            | currWs == ws = "[" ++ ws ++ "]"
            | otherwise    = " " ++ ws ++ " "
          sort' = sortBy (compare `on` (!! 0))

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
        D.signalBody = [D.toVariant $ UTF8.decodeString str]
                                                                }
    D.emit dbus signal
    where
        objectPath = D.objectPath_ "/org/xmonad/log"
        interfaceName = D.interfaceName_ "org.xmonad.Log"
        memberName = D.memberName_ "Update"

------------------------------------------------------------------------
-- Startup hook
myStartupHook = do
    spawn "~/init.sh"

addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
        sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
        when (fromIntegral x `notElem` sup) $
           changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
main :: IO ()
main = do
    forM_ [".xmonad-workspace-log", ".xmonad-title-log"] $ \file -> do
        safeSpawn "mkfifo" ["/tmp/" ++ file]

    dbus <- D.connectSession
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad $ ewmh $ docks $ defaults (dbus)

defaults dbus = def {
      terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor

    , keys               = myKeys
    , mouseBindings      = myMouseBindings

    , layoutHook         = smartBorders $ myLayoutHook
    , manageHook         = myManageHook <+> namedScratchpadManageHook scratchpads <+> manageHook def
    , handleEventHook    = handleEventHook def 
                            <+> fullscreenEventHook
                            <+> serverModeEventHookCmd
                            <+> serverModeEventHook
                            <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
    , logHook            = myDynamicLogHook dbus
    , startupHook        = myStartupHook >> addEWMHFullscreen
    } 
