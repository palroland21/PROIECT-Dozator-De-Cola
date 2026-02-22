# PROIECT – Dozator de Cola (VHDL) 🥤💰

Proiect digital (VHDL) care implementează un automat distribuitor de Coca-Cola cu acceptare de monede și eliberare produs + rest, pe baza unor fotocelule de detecție și a logicii de control/execuție.

---

## 📌 Specificație

Se proiectează un automat distribuitor de Coca Cola cu:
- **Preț produs:** 1 leu (100 bani)
- **Monede acceptate:** 5 bani, 10 bani, 50 bani
- **Fotocelule (intrări):**
  - `F0` – monedă 5 bani
  - `F1` – monedă 10 bani
  - `F2` – monedă 50 bani
  - `F3` – respingere monedă (alt tip) / corp străin
  - `F4` – semnal acceptare monedă
- **Comportament cerut:**
  - Dacă **nu există Coca-Cola în stoc**, nu se acceptă niciun tip de monedă (FS).
  - Se verifică suma totală; monedele sunt **returnate** dacă suma nu este completă (RM).
  - Se eliberează **rest**, dacă este cazul.
  - Se semnalizează: acceptare monedă (AM), total (AT) și eliberare Coca-Cola.

---

## 🧱 Arhitectură (Black Box)

Proiectul este gândit inițial ca un **Black Box** (interfață intrări/ieșiri), apoi detaliat în două module:
- **Unitatea de control (UC):** generează semnale de control și coordonează funcționarea
- **Unitatea de execuție (UE):** realizează calcule și actualizări (sumă, decizie eliberare/rest etc.)

Această abordare ajută la separarea clară dintre **control** (decizii) și **datapath** (calc/operare).

---

## 🔌 Interfață (I/O)

### Intrări
- `CLK` – semnal de ceas
- `Reset` – reset sistem
- `F0` – monedă 5 bani
- `F1` – monedă 10 bani
- `F2` – monedă 50 bani
- `F3` – respingere monedă / corp străin
- `BTN_Eliberare_Cola` – buton eliberare cola

### Ieșiri
- `AcceptareMoneda` – semnal acceptare monedă
- `EliberareCola` – semnal eliberare cola
- `EliberareRest` – semnal eliberare rest
- `FonduriInsuficiente` – semnal fonduri insuficiente

---

## 🧩 Componente interne

### 1) MUX 4:1
Un multiplexor selectează una dintre intrări și trimite valoarea către ieșire, pe baza liniilor de selecție.  
În proiect, MUX-ul este folosit pentru selectarea valorii monedei detectate:
- `F0` → 5 bani
- `F1` → 10 bani
- `F2` → 50 bani
- `F3` → respingere / corp străin (nu se adaugă bani)

### 2) Adder (sumator) 8 biți
Suma introdusă de utilizator se calculează cu un **adder de 8 biți**, construit din sumatoare complete (full adders) conectate în lanț.

Formule full adder:
- `S = A xor B xor Cin`
- `Cout = (A and Cin) or (B and Cin) or (A and B)`

Adder-ul de 8 biți adună incremental valoarea monedelor acceptate la totalul curent.

### 3) Main (integrare)
Modulul principal:
- declară componentele
- face maparea conexiunilor
- gestionează intrările/ieșirile
- coordonează fluxul: detecție monedă → sumă → decizie eliberare/returnare/rest

---

## ✅ Logică de funcționare (pe scurt)

1. **Detecție monedă**
   - Dacă se detectează `F0/F1/F2` → se determină valoarea monedei prin MUX și se adaugă la total (via adder).
   - Dacă `F3` (corp străin/monedă neacceptată) → moneda este respinsă, nu se modifică totalul.

2. **Eliberare produs**
   - Utilizatorul apasă `BTN_Eliberare_Cola` pentru a cere produsul.

3. **Verificare fonduri**
   - Dacă total < 100 bani:
     - `FonduriInsuficiente` = 1
     - monedele introduse sunt returnate
   - Dacă total ≥ 100 bani:
     - `EliberareCola` = 1
     - dacă total > 100 → se activează `EliberareRest` pentru rest

4. **Stoc indisponibil**
   - Dacă nu există cola în stoc: automatul nu acceptă monede (conform cerinței FS).

---

## 🧾 Manual de utilizare

1. Introdu monede de **5 / 10 / 50 bani**.
2. Dacă introduci o monedă greșită / corp străin, sistemul o respinge automat.
3. Apasă `BTN_Eliberare_Cola` pentru a primi produsul.
4. Sistemul decide automat:
   - dacă ai ≥ 100 bani → eliberează cola (+ rest dacă e cazul)
   - dacă ai < 100 bani → semnalizează fonduri insuficiente și returnează monedele

---

## 🛠️ Întreținere (în lumea reală)

- verificare periodică a fotocelulelor și a butonului
- înlocuire componente uzate/defecte
- curățare săptămânală
- golirea monedelor și reumplerea stocului de cola
- evitarea introducerii de corpuri străine (poate defecta sistemul)

---

## 🚀 Posibilități de dezvoltare

- mai multe arome de cola
- afișare prețuri diferite per produs
- plată electronică
- aplicație mobilă pentru monitorizarea stocului și a fondurilor (pentru deținător)
- securitate îmbunătățită
- localizare GPS a automatelor (pentru client)

---

## 👤 Autor

**Pal Roland**  
Universitatea Tehnică din Cluj-Napoca – Calculatoare
