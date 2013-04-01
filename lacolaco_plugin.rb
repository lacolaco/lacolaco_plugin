# -*- coding: utf-8 -*-

Plugin.create(:lacolaco_plugin) do

  launched_time = Time.now

  on_appear do |ms|
    ms.each do |m|
      if m[:created] < launched_time
        false
      elsif m.message.to_s.include?("らこらこらこ")
        lacolaco
      end
    end
  end

  on_unfavorite do |service, user, message|
    # enkunkun.id = 159733526
    if message.user.id == 159733526
      lacolaco
    end
  end

  command(
    :lacolaco_plugin,
    name: "らこらこする",
    visible: false,
    role: :window,
    condition: lambda{ |opt| true }
  )do |opt|
    lacolaco(true)
  end

  def lacolaco(flag = false)
    Plugin.call(:lacolaco) if flag

    Service.primary.update(:message => "らこらこらこ〜ｗ").trap{
      if flag
        activity :system, "失敗しました"
      end
    }
  end
end
