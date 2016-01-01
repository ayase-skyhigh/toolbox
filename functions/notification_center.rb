module NotificationCenter

  ## 参考
  # http://qiita.com/zakuroishikuro/items/cfba3e7734036e389768

  ## 通知
	def notification(message, title:"Ruby", subtitle:"", sound:"")
		[message, title, subtitle, sound].each{|arg| arg.gsub!(/"/, '\\\\\"')}

		scpt = 'display notification "%s"' % message
		scpt << ' with title "%s"' % title
		scpt << ' subtitle "%s"' % subtitle unless subtitle.empty?
		scpt << ' sound name "%s"' % sound unless sound.empty?

		system %|osascript -e "#{scpt.gsub(/"/, '\"')}"|
  end

	# 使い方
	# ダブルクォーテーション、シングルクォーテーションが問題なく使えること確認
	# notification %q|"I thought what I'd do was, I'd pretend I was one of those deaf-mutes."|, sound:'Glass'

end
