# 🧬 Sequential Sentence Classification — PubMed 20k RCT
## AI Engineer Capstone Project

---

## 📁 Project Structure

```
capstone_project/
├── Sequential_Sentence_Classification.ipynb   ← Main notebook (42 cells, 11 sections)
├── setup_venv.bat                             ← Windows setup (Command Prompt)
├── setup_venv.ps1                             ← Windows setup (PowerShell)
├── README.md                                  ← This file
└── pubmed_data/
    └── PubMed_20k_RCT/
        ├── train.txt   (~180k sentences, ~15k abstracts)
        ├── dev.txt     (~30k sentences)
        └── test.txt    (~30k sentences)
```

---

## ⚙️ Environment Setup — Windows (Python venv)

### Option A: Command Prompt / Double-click
```bat
setup_venv.bat
```

### Option B: PowerShell
```powershell
powershell -ExecutionPolicy Bypass -File setup_venv.ps1
```

### Option C: Manual steps
```bat
:: 1. Create venv — inherits system site-packages automatically
python -m venv --system-site-packages venv

:: 2. Activate
venv\Scripts\activate.bat

:: 3. (Optional) Install deep learning packages — needed for Models 2-4
pip install tensorflow==2.18.0 tensorflow-hub
pip install transformers==4.35.0
pip install torch==2.2.0

:: 4. Register Jupyter kernel and launch
pip install jupyter ipykernel
python -m ipykernel install --user --name=capstone_venv --display-name "Python (capstone_venv)"
jupyter notebook Sequential_Sentence_Classification.ipynb
```

> **Note:** Models 0 & 1 run immediately with core packages.
> Models 2–4 require the optional DL installs above.

---

## ⚠️ PowerShell Execution Policy

If PowerShell blocks the script, run this once as Administrator:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Or pass the bypass flag per-run:
```powershell
powershell -ExecutionPolicy Bypass -File setup_venv.ps1
```

---

## 🤖 Models

| # | Model | Architecture | Expected Accuracy |
|---|---|---|---|
| 0 | Naïve Bayes + TF-IDF | Classical ML baseline | ~73% |
| 1 | Conv1D Token Embedding | Token embed → Multi-scale Conv1D → Dense | ~81% |
| 2 | USE Feature Extractor | Universal Sentence Encoder (512d) → Dense | ~84% |
| 3 | Conv1D Char Embedding | Char embed → 5-kernel Conv1D → Dense | ~79% |
| 4 | BERT Fine-tuning | bert-base-uncased → [CLS] → Linear head | ~90% |

---

## 📊 Labels

`BACKGROUND` · `OBJECTIVE` · `METHODS` · `RESULTS` · `CONCLUSIONS`

---

*Capstone Project | AI Engineer Program*
