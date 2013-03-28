# -*- coding: utf-8 -*-

Plugin.create(:lacolaco_plugin) do
    command(:lacolaco_plugin,
        name: "らこらこする",
        visible: false,
        role: :window,
        condition: lambda{ |opt| true }
        ) do |opt|
            Service.primary.update(:message => "らこらこらこ〜ｗ").trap{
                Service.primary.update(:message => "らこらこらこ〜ｗｗ").trap{
                    Service.primary.update(:message => "らこらこらこ〜ｗｗｗ").trap{
                        Service.primary.update(:message => "らこらこらこ〜ｗｗｗｗ").trap{
                            Service.primary.update(:message => "らこらこらこ〜ｗｗｗｗｗ").trap{
                                Plugin.call(:message, nil, [Message.new(:message => "失敗しました", :system => true)])
                            }
                        }
                    }
                }
            }
    end
end