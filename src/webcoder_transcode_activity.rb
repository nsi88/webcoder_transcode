require 'ruboto/widget'
require 'ruboto/util/toast'

ruboto_import_widgets :LinearLayout, :EditText, :Button, :TextView

class WebcoderTranscodeActivity
  STATE_STOPPED = :stopped
  STATE_STARTED = :started

  def onCreate(bundle)
    super
    set_title 'Webcoder Transcode'

    @state = STATE_STOPPED

    self.content_view = linear_layout orientation: :vertical do
      @host = edit_text(single_line: true, hint: 'Segmenter host')
      @start_stop = button(text: 'Start', on_click_listener: proc { toggle_state })
      @log = text_view(layout: { width: :match_parent })
    end
  rescue Exception
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private

  def toggle_state
    @state == STATE_STOPPED ? start : stop
  end

  def start
    if @host.text.empty?
      log('Enter segmenter host')
      return
    end
    log("Connecting to #{@host.text} ...")
  end

  def stop
  end

  def log(msg)
    @log.text += msg + "\n"
  end
end
