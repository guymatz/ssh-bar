#!/usr/bin/ruby

require 'gtk2'

class RubyApp < Gtk::Window

  def initialize
    super
    
    # Set the title of the gtk box
    set_title "SSH to  . . ."
    # What to do if gtk box is cancelled
    signal_connect "destroy" do
      Gtk.main_quit
    end

    # Call function to assemble the UI (defined below)
    init_ui

    # Positioning of UI
    set_default_size 250,200
    set_window_position Gtk::Window::POS_CENTER

    # And finally display the UI
    show_all

  end

  def init_ui

    fixed = Gtk::Fixed.new

    # Text entry for where to ssh to
    entry = Gtk::Entry.new
    # What to do if "enter" is pressed while in the entry field
    entry.signal_connect( "activate" ) { |e| open_xterm( e ) }
    fixed.put entry, 50, 50

    # Unnecessary button
    button = Gtk::Button.new "Go"
    fixed.put button, 60, 100

    # What to do when button is pressed
    button.signal_connect "clicked" do
      open_xterm entry
    end

    add fixed
  end

  def open_xterm ( entry )
    # Should have a way of config'ing which xterm to open, or using a 
    # system default
    # SHould check that the machine exists and give a warning if it
    # can't be found in DNS, etc.
    #puts "/usr/bin/xfce4-terminal --command \"ssh -XY #{entry.text}\""
    exec("/usr/bin/xfce4-terminal --command \"ssh -XY #{entry.text}\"")
    Gtk.main_quit
  end

end

# main
Gtk.init
  window = RubyApp.new
Gtk.main
