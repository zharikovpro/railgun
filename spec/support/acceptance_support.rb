module AcceptanceSupport
  def screenshot_with_outline(outline)
    screenshot(outline: outline)
  end

  def screenshot(outline: nil)
    return unless ENV['CI'].nil?
    page.execute_script("$('#{outline}').css('outline', '9px solid magenta')") if outline

    screenshot_and_open_image

    page.execute_script("$('#{outline}').css('outline', 'none')") if outline
  end
end
