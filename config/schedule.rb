# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + '/environment')
# 実行環境を指定する
set :environment, :production  # 本番環境に変更
# set :environment, Rails.env.to_sym
# 実行logの出力先
set :output, "#{Rails.root.to_s}/log/cron.log"

# Time クラスの拡張を利用するため ActiveSupport を require する
require 'active_support/core_ext/time'

# 時刻の文字列を日本時間で解釈して、システムのタイムゾーンに変換
def jst(time)
  Time.zone = 'Asia/Tokyo'
  Time.zone.parse(time).localtime($system_utc_offset)
end

# 日本時間の 午前 00:00にバッチをスケジュール
# every 1.minutes do
# # every 1.day, at: jst('00:00 am') do
#   # runner "Event.recruitment_end"
#   logger.debug(“処理が走りました”)

  every 1.day, at: jst('00:00 am') do
    runner "Tasks::Eventupdatetask.recruitment_end"
  end
# end