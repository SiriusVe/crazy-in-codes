extends Control

@onready var question_txt: Label = $QuizUI/QuestionPanel/QuestionTxt
@onready var cd_txt: Label = $QuizUI/QuestionPanel/CdPanel/CdTxt

@onready var a: Button = $QuizUI/QuestionPanel/Answers/A
@onready var b: Button = $QuizUI/QuestionPanel/Answers/B
@onready var c: Button = $QuizUI/QuestionPanel/Answers/C
@onready var d: Button = $QuizUI/QuestionPanel/Answers/D

var questao_atual = 0


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
	var questao = questoes[questao_atual]
	
	question_txt.text = questao["pergunta"]
	cd_txt.text = questao["codigo"]
	
	a.text =  questao["alternativas"][0]
	b.text =  questao["alternativas"][1]
	c.text =  questao["alternativas"][2]
	d.text =  questao["alternativas"][3]
	 
func _ready():
	mostrar_questao()
