extends Area3D

func _ready():
	# เชื่อมต่อสัญญาณเมื่อมีอะไรเข้ามาชน
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# ตรวจสอบว่าเป็น player หรือไม่
	if body.name == "Player":
		show_win_message()

func show_win_message():
	print("You Win!")
	
	# สร้าง UI ใหม่แบบง่ายๆ
	var canvas_layer = CanvasLayer.new()
	get_tree().current_scene.add_child(canvas_layer)
	
	var win_label = Label.new()
	canvas_layer.add_child(win_label)
	
	# ตั้งค่า Label
	win_label.text = "🌟 CYBER VICTORY! 🌟\n✨ 663380303-5 ✨\n🎮 อัษฎาวุธ เรือนแก้ว 🎮\n💫 NEON CHAMPION! 💫"
	win_label.add_theme_font_size_override("font_size", 48)
	win_label.add_theme_color_override("font_color", Color.CYAN)
	win_label.add_theme_color_override("font_outline_color", Color.MAGENTA)
	win_label.add_theme_constant_override("outline_size", 6)
	
	# วางตรงกลาง
	win_label.anchors_preset = Control.PRESET_CENTER
	win_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	win_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# เพิ่มเอฟเฟกต์ขยาย
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(win_label, "scale", Vector2(1.2, 1.2), 0.5)
	tween.tween_property(win_label, "scale", Vector2(1.0, 1.0), 0.5)
	
	# หยุดเกมชั่วคราว
	get_tree().paused = true
	
	# รอ 3 วินาที แล้วรีสตาร์ท
	await get_tree().create_timer(3.0, true, false, true).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
