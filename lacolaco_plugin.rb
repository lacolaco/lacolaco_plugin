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
    Service.primary.update(:message => "らこらこらこ〜ｗ").trap{
      Plugin.call(:message, nil, [Message.new(:message => "失敗しました", :system => true)])
    }
  end
end
