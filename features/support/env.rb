require 'rubygems'
require 'rspec/expectations'
require 'watir'
#require 'watir-webdriver'
require 'win32ole'
require 'singleton'
require 'fileutils'
require 'net/smtp'
require 'mailfactory'
require 'erb'
#require File.dirname(__FILE__) + '\page\common.rb'
Browser = Watir::Browser
#Browser = Watir::Browser :IE

$DEBUG = false 
Before do
	init_folder("d:/AutoThc")
	clear_cookie
	@browser = Browser.new
	@browser.wait
	@browser.bring_to_front
	@browser.maximize
end

After do
	@browser.close
	sleep 2
end
