#
# The current require dance for different Ruby versions.
# Change this to suit your requirements.
#
if Kernel.respond_to?(:require_relative)
  require_relative("./stomp11_common")
  require_relative("./slogger")
else
  $LOAD_PATH << File.dirname(__FILE__)
  require "stomp11_common"
  require "slogger"
end
include Stomp11Common
#
# Stomp 1.1 Heartbeat Example 1
# =============================
#
# Purpose: to demonstrate that heart beats can work.
#
# Create connection headers
# =========================
#
conn_hdrs = {"accept-version" => "1.1",    # 1.1
      "host" => virt_host,                 # vhost
      "heart-beat" => "5000,10000",        # heartbeats
    }
# Create a logger for demonstration purposes
logger = Slogger.new
# Connect
conn = Stomp::Connection.new(login, passcode, host, port,   # Normal connect parms
  false,      # Not reliable, the default
  5,          # Connect redelay, the default
  conn_hdrs)  # The 1.1 connection parameters
puts "Connection complete"
#
raise "Unexpected protocol level" if conn.protocol != Stomp::SPL_11
#
conn.set_logger(logger) # Connection uses a logger
sleep 65
conn.set_logger(nil)    # No logging
#
conn.disconnect   # Get out
puts "Disconnect complete"



