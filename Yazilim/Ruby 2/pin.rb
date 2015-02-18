class Pin

	## 0  -> ANALOG
	## 1  -> OUTPUT
	## 2  -> INPUT
	## 3  -> SERVO

	$arduino_mega = {
		{2 => 'motor_sol_on'} => 1,
		{3 => 'motor_sol_arka'} => 1,
		{4 => 'motor_sag_on'} => 1,
		{5 => 'motor_sag_arka'} => 1,
		{6 => 'servo_x'} => 3,
		{7 => 'servo_y'} => 3,

		{22 => 'motor_sol_on_yon'} => 1,
		{23 => 'motor_sol_arka_yon'} => 1,
		{24 => 'motor_sag_on_yon'} => 1,
		{25 => 'motor_sag_arka_yon'} => 1,
		{26 => 'hareket_on_sag'} => 2,
		{27 => 'hareket_on_sol'} => 2,
		{28 => 'hareket_arka_sag'} => 2,
		{29 => 'hareket_arka_sol'} => 2,
		{30 => 'buzzer_1'} => 1,
		{31 => 'buzzer_2'} => 1,
		{32 => 'ses_sensoru'} => 2,
		{33 => 'ekran_sag_isik'} => 1,
		{34 => 'ekran_sol_isik'} => 1,

		{0 => 'motor_sol_on_hiz'} => 0,
		{1 => 'motor_sol_arka_hiz'} => 0,
		{2 => 'motor_sag_on_hiz'} => 0,
		{3 => 'motor_sag_arka_hiz'} => 0,
		{4 => 'uzaklik_sag_on'} => 0,
		{5 => 'uzaklik_sag_arka'} => 0,
		{6 => 'uzaklik_sol_on'} => 0,
		{7 => 'uzaklik_sol_arka'} => 0,
		{8 => 'sicaklik_sensoru'} => 0,
		{9 => 'gaz_sensoru'} => 0,
		{10 => 'uzaklik_on_alt_1'} => 0,
		{11 => 'uzaklik_on_alt_2'} => 0,
		{12 => 'uzaklik_on_ust_1'} => 0,
		{13 => 'uzaklik_on_ust_2'} => 0,
		{14 => 'uzaklik_arka_1'} => 0,
		{15 => 'uzaklik_arka_2'} => 0,
	}


	def megaPin
		return $arduino_mega
	end

	def hareket_on_sag
		$arduino_mega.each do |a,b|
			a.each do |x,y|
				if y == 'hareket_on_sag'
					return x
				end
			end
		end
	end

	def hareket_on_sol
		$arduino_mega.each do |a,b|
			a.each do |x,y|
				if y == 'hareket_on_sol'
					return x
				end
			end
		end
	end

	def hareket_arka_sag
		$arduino_mega.each do |a,b|
			a.each do |x,y|
				if y == 'hareket_arka_sag'
					return x
				end
			end
		end
	end

	def hareket_arka_sol
		$arduino_mega.each do |a,b|
			a.each do |x,y|
				if y == 'hareket_arka_sol'
					return x
				end
			end
		end
	end

end