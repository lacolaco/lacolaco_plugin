# -*- coding: utf-8 -*-

Plugin.create(:lacolaco_plugin) do

  SOUND_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'laco.wav'))
  launched_time = Time.now
  UserConfig[:laco_point] ||= 0
  UserConfig[:laco_require_points] ||= 5

  on_appear do |ms|
    ms.each do |m|
      if m.user[:id] == 498602690 && laco_oruka?
        laco_orudew m[:created]
      end
      if !(m[:created] < launched_time) &&
          !m.retweet? &&
          !m.user.is_me? &&
          m.message.to_s.include?("らこらこらこ")
        get_laco_point
        Plugin.call(:lacolaco, true)
        if m.retweet?
          if m.retweet_source.user.is_me? == false
            m.favorite(true)
          end
        elsif m.user.is_me? == false
          m.favorite(true)
        end
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
    if !passive || rand(3) == 0
      if UserConfig[:laco_point] < UserConfig[:laco_require_points]
        activity :system, "らこらこポイントが足りないよ (#{UserConfig[:laco_point]} pts)"
      else
        Service.primary.update(:message => "らこらこらこ〜ｗ").next {
          UserConfig[:laco_point] -= UserConfig[:laco_require_points]
        }.trap {
          unless passive
            activity :system, "失敗しました"
          end
        }
      end
    end
  end

  settings "らこらこ" do
    boolean "えんくんあんふぁぼ機能", :laco_enkun
    boolean "通知音" , :laco_notify
  end

  # らこらこ〜おるか？ｗ
  def laco_oruka?
    defined?(@last_laco_time) && @last_laco_time > (Time.now - 600)
  end

  # らこらこがおる時にこれを呼ぶ
  def laco_orudew(time)
    @last_laco_time = time
  end

  # らこらこポイントを獲得。 laco_oruka? が真を返す場合はポイント二倍セール。
  def get_laco_point(given=1)
    if laco_oruka?
      UserConfig[:laco_point] += given * 2
    else
      UserConfig[:laco_point] += given
    end
    notify_sound
  end
  
  #通知音だ　心して聞け
  def self.notify_sound()
    if UserConfig[:laco_notify] and FileTest.exist?(SOUND_PATH)
      Plugin.call(:play_sound, SOUND_PATH) end end

end
