import subprocess
import shlex
import os

def predict(input_text, model_path):
	model_path = os.path.abspath(model_path)
	current_path = os.path.abspath(".")
	f = open("../live_prediction/data.txt", "w")
	f.write(input_text)
	f.close()
	subprocess.call(["./scripts/predict.sh",model_path])
	pr_f = open("../live_prediction/pred.txt", "r")
	return pr_f.read()

if __name__ == '__main__':
	simplified_text = predict("Text simplification is an operation used in natural language processing to modify, enhance, classify or otherwise process an existing corpus of human-readable text in such a way that the grammar and structure of the prose is greatly simplified, while the underlying meaning and information remains the same.", "../models/nts_epoch11_8.49.t7")	
	print(simplified_text)