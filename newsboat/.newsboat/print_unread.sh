#!/bin/bash

query="select count(*) from rss_item where unread=1;"
sqlite3 ~/.newsboat/cache.db "$query"
