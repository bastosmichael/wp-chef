require 'uuidtools'

default['bluepill_test']['service_name'] = "test_app"
default['bluepill_test']['tcp_server_listen_port'] = 1234
default['bluepill_test']['secret'] = UUIDTools::UUID.random_create.to_s
