require_relative 'gbm_helper'

class GBMInitTest < Minitest::Test
  @path = Pathname(File.expand_path(File.dirname(__FILE__)) + '/../config/keys' )
  @key = OpenSSL::PKey::RSA.new(File.read(@path +'gbm.sec'))
  @skey = @key.to_pem
  @pkey = @key.public_key.to_pem
  gbm = GrantedByMe.new @key, nil
#  gbm = GrantedByMe.new nil,nil
  assert_equal gbm.activate_service('XMKp6Whq4ACUyhBO6BQTJ6DZfxTGTCtHwlR0A6uPLvddrxypmOpZtFE3LtMi80qWeEn7ToeruEOfCKs4zUkWDAFfifVbZbS08GzEGCdEDvyMXN0VA3ztXyrNRWLuM8DF'), '{"success": false}'
end