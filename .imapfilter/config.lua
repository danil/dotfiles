package.path = package.path .. ";/home/danil/.imapfilter/?.lua"
require "config/options"
require "config/danil_at_kutkevich_org"
-- require "config/lera_at_kutkevich_ru"

-- filtering_lera_at_kutkevich_ru()
filtering_danil_at_kutkevich_org()
