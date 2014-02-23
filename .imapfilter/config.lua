package.path = package.path .. ";/home/danil/.imapfilter/?.lua"
require "config/options"
require "config/gmail"
gmail_filtering()
