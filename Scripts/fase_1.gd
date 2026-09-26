extends Control

@onready var question_txt: Label = $QuizUI/QuestionPanel/QuestionTxt
@onready var cd_txt: Label = $QuizUI/QuestionPanel/CdPanel/CdTxt

@onready var a: Button = $QuizUI/QuestionPanel/Answers/A
@onready var b: Button = $QuizUI/QuestionPanel/Answers/B
@onready var c: Button = $QuizUI/QuestionPanel/Answers/C
@onready var d: Button = $QuizUI/QuestionPanel/Answers/D

@onready var mental_bar: ProgressBar = $QuizUI/MentalBar
@onready var timer_txt: Label = $QuizUI/QuestionPanel/Timertxt


var mental = 100.00
var questao_atual = 0
var time = 20.0
var timeR = 20.0
var error = 10.0
var fim_questao = false

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

func mostrar_questao():
	timeR = time
	var questao = questoes[questao_atual]
	
	question_txt.text = questao["pergunta"]
	cd_txt.text = questao["codigo"]
	
	a.text =  questao["alternativas"][0]
	b.text =  questao["alternativas"][1]
	c.text =  questao["alternativas"][2]
	d.text =  questao["alternativas"][3]
	
	timer_txt.text = str(ceil(timeR))

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
	mostrar_questao()
	a.pressed.connect(func(): verificar_resposta(0))
	b.pressed.connect(func(): verificar_resposta(1))
	c.pressed.connect(func(): verificar_resposta(2))
	d.pressed.connect(func(): verificar_resposta(3))


func _process(delta):
	timeR -= delta
	timer_txt.text = str(ceil(timeR))
	mental -= (100.0 / time) * delta
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
	
