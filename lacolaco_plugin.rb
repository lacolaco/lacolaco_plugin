# -*- coding: utf-8 -*-

Plugin.create(:lacolaco_plugin) do

  launched_time = Time.now

  on_appear do |ms|
    ms.each do |m|
      if m[:created] < launched_time
        false
      elsif m.retweet?()
        false
      elsif m.message.to_s.include?("らこらこらこ")
        Plugin.call(:lacolaco, true)
        m.favorite(true)
      end
    end
  end

  on_unfavorite do |service, user, message|
    if UserConfig[:laco_enkun]
      # enkunkun.id = 159733526
      if message.user.id == 159733526
        Plugin.call(:lacolaco, true)
      end
    end
  end

  command(
    :lacolaco_plugin,
    name: "らこらこする",
    visible: false,
    role: :window,
    condition: lambda{ |opt| true }
  )do |opt|
    Plugin.call(:lacolaco, false)
  end

  on_lacolaco do |passive|
    unless passive && rand(3) != 0
      
    else
      Service.primary.update(:message => "らこらこらこ〜ｗ").trap{
      unless passive
        activity :system, "失敗しました"
      end
    }
    end
  end

  settings "らこらこ" do
    boolean "えんくんあんふぁぼ機能", :laco_enkun
  end
  
end
