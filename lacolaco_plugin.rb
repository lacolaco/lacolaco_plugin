# -*- coding: utf-8 -*-

Plugin.create(:lacolaco_plugin) do

    command(:lacolaco_plugin,
        name: "らこらこする",
        visible: false,
        role: :window,
        condition: lambda{ |opt| true }
        ) do |opt|
        lacolaco_w
    end

  def lacolaco_w
    Service.primary.update(:message => "らこらこらこ〜" + sign).trap{
      Plugin.call(:update, nil, [Message.new(:message => "失敗しました", :system => true)])
    }
  end

  def sign
    "ｗ" * (sign_counter.call % 8 + 1)
  end

  def sign_counter
    @sign_counter ||= gen_counter
  end

end
