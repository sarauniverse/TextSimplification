
# Text Simplification

## Abstract
The neural text simplification concurrently performs lexical simplification and content reduction. The neural networks can be trained end to end without the need of having external decoders. The text simplification process proposed by [Sergiu Nisioi et. al](https://www.aclweb.org/anthology/P17-2014/) uses the sequence to sequence modeling for simplifying and shortening the text. The authors used Python and Lua programming language for executing the tasks and predicting the BLEU and SARI scores. The main aim of this project is to reproduce the tasks performed by Sergiu Nisioi et. al to get approximately the same BLEU and SARI scores with a different dataset. 

## Dataset
In order to reproduce [Sergiu Nisioi et. al](https://www.aclweb.org/anthology/P17-2014/) result, [WikiSmall](https://github.com/XingxingZhang/dress) dataset is used. 

## How to run 
1. Lua based implementation of OpenNMT is required<br/>
  1.1  [Install Torch](http://torch.ch/docs/getting-started.html) <br/>
  1.2  Install additional packages: 
    ```bash 
    luarocks install tds
    ```
    There is no need to clone the OpenNMT repository as it is included within this repository.
2. Python 3+ is required <br/>
  2.1. Install [Python](https://www.python.org/downloads/)
3. Checkout this repository
   ```bash 
   git clone --recursive https://github.com/sarauniverse/TextSimplification
   ```
4. Download the model for simplification. Model is trained with 14 epochs.  Hence 14 models were created. The model with the highest BLEU and SARI score is uploaded in the Dropbox. The model can be downloaded by running the following python script.
```bash
   python src/download_model.py
```
5. To download the model used by Sergiu Nisioi et. al](https://www.aclweb.org/anthology/P17-2014/), run the following python script
```bash
   python src/download_author_models.py
```
6. To perform the predictions for the test data. Run the following command
```bash
   cd src/scripts 
   ./translate.sh ../../models/nts_epoch11_8.49.t7
```
7. nts_epoch11_8.49.t7 is the model file with best BLEU and SARI score. The prediction against the test dataset (available in the directory /data) is already included in the /prediction. To see the SARI and BLEU score of our model compared with  Sergiu Nisioi et. al and other models -  (Wubben et al., 2012), (Glavas and Stajner, 2015), and (Xu et al., 2016), run the following command.
```bash
 python src/evaluate.py ./data/test_src.en ./data/references/references.tsv ./predictions/ ./eval_output
   ```
You will see BLEU and SARI generated in two files **prediction_bleu_score.csv** and **prediction_sari_score.csv** in the folder **eval_output**
    
**Note** 
1.  If you want to include the predictions against the same test dataset (/data ) made by the some other model, please add the prediction output file to the folder **/predictions** and run the above script.
2. This code is well tested with MacOS. If you want to run in Linux replace `greadlink` with `readlink` in the shell scripts.

## Training from the scratch
1. Preprocess the data<br/>
Replace the existing dataset with your dataset in the **/data** directory and run the following command. Retain the same name in the **/data** directory  because the following script looks for that file names.
  ```bash
  cd src/scripts
  ./prepocess.sh
   ```
The outputs will be generated in the **/data/preprocessed**  directory 

2. To include the pre-trained Google News embedding as the global embedding, run the following command
 ```bash
  cd src/scripts
  ./download_global_embeddings.sh
  ./create_embeddings.sh
   ```
   The embedding files are generated in the **/data/embed** directory.

3. Start the training
```bash
  cd OpenNMT/
  th train.lua -config ../configs/NTS.cfg
```
You can make changes to the config file as per your requirement. If you are using pre-trained embedding, specify the path of the embedding the config file for the fields **pre_word_vecs_dec**, **pre_word_vecs_enc**.
**Note** : Training usually takes longer time.

4. After the training has been completed, you will have n number of model files generated as you have specified in the NTS.cfg file for the field **end_epoch**. Perform text simplification against the test dataset for each model generated using the following command
```bash
   cd src/scripts 
   ./translate.sh ../../models/<model_file>
```
5. You have to pick the best performing model by computing the BLEU and SARI score for each model. This can be done by running the following python script.
```bash
   cd src/ 
   python evaluate_sari_bleu.py ../data/test_src.en ../data/references/references.tsv ../eval_output/bleu.csv ../eval_output/sari.csv
```
SARI and BLEU scores for all hypotheses of each model are stored in the **/eval_output/bleu.csv** and **/eval_output/sari.csv** files. Pick the model with the highest BLEU and SARI scores. 

6. Copy and paste the highest prediction output files to the **/predictions** and run the following command to see the comparison.
```bash
 python src/evaluate.py ./data/test_src.en ./data/references/references.tsv ./predictions/ ./eval_output
   ```
## Live Text Simplification in the Jupyter Notebook
You can find the live text simpflication and the visual representation of the SARI and BLEU scores comparison with bar graph in the Jupyter notebook file **/src/Neural_Text_Simplification.ipynb**

## Credits
This repository is based on the code from the repository [https://github.com/senisioi/NeuralTextSimplification](https://github.com/senisioi/NeuralTextSimplification) and the [research paper](https://www.aclweb.org/anthology/P17-2014/)
```
  @InProceedings{neural-text-simplification,
    author    = {Sergiu Nisioi and Sanja Štajner and Simone Paolo Ponzetto and Liviu P. Dinu},
    title     = {Exploring Neural Text Simplification Models},
    booktitle = {{ACL} {(2)}},
    publisher = {The Association for Computational Linguistics},
    year      = {2017}
  }
```
