extends Control
@onready var quiz_ui: Control = $QuizUI

@onready var camera_2d: Camera2D = $Camera2D

@onready var question_txt: Label = $QuizUI/QuestionPanel/QuestionTxt
@onready var cd_txt: Label = $QuizUI/QuestionPanel/CdPanel/CdTxt

@onready var a: Button = $QuizUI/QuestionPanel/Answers/A
@onready var b: Button = $QuizUI/QuestionPanel/Answers/B
@onready var c: Button = $QuizUI/QuestionPanel/Answers/C
@onready var d: Button = $QuizUI/QuestionPanel/Answers/D

@onready var mental_bar: ProgressBar = $QuizUI/MentalBar
@onready var timer_txt: Label = $QuizUI/QuestionPanel/Timertxt

@onready var mesa_pc: TextureRect = $MesaPC
@onready var tela_cheia: TextureRect = $TelaCheia

var mental = 100.00
var questao_atual = 0
var time = 20.0
var timeR = 20.0
var error = 5.0
var fim_questao = false
var fimzoom = false

var questoes = [
	{
		"linguagem": "C",
		"pergunta": "Qual será a saída deste código?",
		"codigo": "int x = 10;\nprintf(\"%d\", x + 5);",
		"alternativas": [
			"5",
			"10",
			"15",
			"20"
		],
		"correta": 2
	},
	
	{
		"linguagem": "Python",
		"pergunta": "Qual será a saída deste código?",
		"codigo": "x = 10\nprint(x + 5)",
		"alternativas": [
			"5",
			"10",
			"15",
			"20"
		],
		"correta": 2
	}
]

func camera_control():
	camera_2d.zoom = Vector2(0.5,0.5)
	var tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(0.9,0.9),5.0)
	await tween.finished
	await get_tree().create_timer(1.0).timeout
	tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(3.8,3.8), 2.5)
	await tween.finished
	mesa_pc.visible = false
	tela_cheia.visible = true
	await get_tree().create_timer(0.5).timeout
	tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(1,1), 3)
	

func mostrar_questao():
	quiz_ui.visible = true
	timeR = time
	var questao = questoes[questao_atual]
	
	question_txt.text = questao["pergunta"]
	cd_txt.text = questao["codigo"]
	
	a.text =  questao["alternativas"][0]
	b.text =  questao["alternativas"][1]
	c.text =  questao["alternativas"][2]
	d.text =  questao["alternativas"][3]
	
	timer_txt.text = str(ceil(timeR))
	fimzoom = true
	
func verificar_resposta(resposta: int):
	if fim_questao:
		return
	
	fim_questao = true
	
	var questao = questoes[questao_atual]
	if resposta == questao["correta"]:
		print("Resposta Correta")
	else:
		print("Resposta Incorreta")
		mental -= error
		mental = max(mental, 0.0)
		mental_bar.value = mental
	
	proxima_questao()
	
func proxima_questao():
	questao_atual += 1
	
	if questao_atual >= questoes.size():
		print("Fim questoes")
		return
	
	fim_questao = false
	mostrar_questao()
	
	print("Nova questão! Timer:", timeR)
	
func _ready():
	camera_control()
	questoes.shuffle()
	
	await get_tree().create_timer(14).timeout
	mostrar_questao()
	a.pressed.connect(func(): verificar_resposta(0))
	b.pressed.connect(func(): verificar_resposta(1))
	c.pressed.connect(func(): verificar_resposta(2))
	d.pressed.connect(func(): verificar_resposta(3))


func _process(delta):
	if fimzoom:
		timeR -= delta
		timeR = max(timeR, 0)
		timer_txt.text = str(ceil(timeR))
		mental -= (35.0 / time) * delta
		mental = max(mental, 0.0)
		mental_bar.value = mental
		
		if timeR <= 0.0 and not fim_questao:
			timeR = 0.0
			fim_questao = true
			
			print("Tempo esgotado!")
			
			mental -= error
			mental = max(mental, 0.0)
			mental_bar.value = mental
			
			proxima_questao()
	
