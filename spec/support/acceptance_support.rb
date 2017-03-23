module AcceptanceSupport
  def screenshot_with_outline(outline)
    screenshot(outline: outline)
  end

  def screenshot(outline: nil)
    unless ENV['CI']
      if outline
        page.execute_script("$('#{outline}').css('outline', '10px solid magenta')")
      end

      screenshot_and_open_image

      if outline
        page.execute_script("$('#{outline}').css('outline', 'none')")
      end
    end
  end

  def pause
    print 'Press Enter to continue...'
    STDIN.getc
  end
end
