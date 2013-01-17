#!env ruby

require 'gtk2'

class RubyApp < Gtk::Window

	def initialize
		super
		
		set_title "SSH to  . . ."
		signal_connect "destroy" do
			Gtk.main_quit
		end

		init_ui

		set_default_size 250,200
		set_window_position Gtk::Window::POS_CENTER

		show_all

	end

	def init_ui

		fixed = Gtk::Fixed.new

		entry = Gtk::Entry.new
		fixed.put entry, 50, 50

		button = Gtk::Button.new "Go"
		fixed.put button, 60, 100

		button.signal_connect "clicked" do
			puts "/usr/bin/xfce4-terminal --command \"ssh -XY #{entry.text}\""
			exec("/usr/bin/xfce4-terminal --command \"ssh -XY #{entry.text}\"")
			Gtk.main_quit
		end

		add fixed
	end

	def on_key_release sender, event, label
		label.set_text sender.text
	end

end

Gtk.init
	window = RubyApp.new
Gtk.main
