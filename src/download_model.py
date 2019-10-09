import wget
best_model_url = "https://dl.dropboxusercontent.com/s/trn3s6w2oq9dprn/nts_epoch11_8.49.t7"
best_model_file_path = "../models/nts_epoch11_8.49.t7"
wget.download(best_model_url, best_model_file_path) 
print("Model downloaded to the path : "+best_model_file_path)  