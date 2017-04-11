module AcceptanceSupport
  def screenshot_with_outline(outline)
    screenshot(outline: outline)
  end

  def screenshot(outline: nil)
    unless ENV['CI']
      if outline
        page.execute_script("$('#{outline}').css('outline', '9px solid magenta')")
      end

      screenshot_and_open_image

      if outline
        page.execute_script("$('#{outline}').css('outline', 'none')")
      end
    end
  end
end
