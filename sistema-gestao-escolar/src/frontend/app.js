const STORAGE_KEY = "gestao-escolar:alunos:v1";

const initialStudents = [
  { id: "1", matricula: "20260001", nome: "Ana Souza", email: "ana.souza@example.test", situacao: "ATIVO" },
  { id: "2", matricula: "20260002", nome: "Bruno Lima", email: "bruno.lima@example.test", situacao: "ATIVO" }
];

const form = document.querySelector("#student-form");
const list = document.querySelector("#student-list");
const search = document.querySelector("#search");
const message = document.querySelector("#message");
const empty = document.querySelector("#empty");
const cancelEdit = document.querySelector("#cancel-edit");
const fields = Object.fromEntries(["id","matricula","nome","email","situacao"].map(id => [id, document.querySelector(`#${id}`)]));

let students = load();

function load() {
  const saved = localStorage.getItem(STORAGE_KEY);
  if (!saved) {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(initialStudents));
    return structuredClone(initialStudents);
  }
  try { return JSON.parse(saved); }
  catch { localStorage.removeItem(STORAGE_KEY); return structuredClone(initialStudents); }
}

function persist() { localStorage.setItem(STORAGE_KEY, JSON.stringify(students)); }
function normalize(value) { return value.trim(); }

function render() {
  const term = search.value.trim().toLocaleLowerCase("pt-BR");
  const filtered = students
    .filter(s => s.nome.toLocaleLowerCase("pt-BR").includes(term) || s.matricula.includes(term))
    .sort((a,b) => a.nome.localeCompare(b.nome, "pt-BR"));

  list.replaceChildren();
  for (const student of filtered) {
    const row = document.createElement("tr");
    for (const value of [student.matricula, student.nome, student.email || "—", student.situacao]) {
      const cell = document.createElement("td");
      cell.textContent = value;
      row.append(cell);
    }
    const actions = document.createElement("td");
    actions.append(button("Editar", () => edit(student.id)), button("Excluir", () => remove(student.id), "danger"));
    row.append(actions);
    list.append(row);
  }
  empty.hidden = filtered.length > 0;
}

function button(label, action, className = "secondary") {
  const element = document.createElement("button");
  element.type = "button";
  element.textContent = label;
  element.className = className;
  element.addEventListener("click", action);
  return element;
}

function edit(id) {
  const student = students.find(item => item.id === id);
  Object.entries(student).forEach(([key,value]) => { if (fields[key]) fields[key].value = value; });
  cancelEdit.hidden = false;
  document.querySelector("#form-title").textContent = "Editar aluno";
  fields.nome.focus();
}

function resetForm() {
  form.reset();
  fields.id.value = "";
  cancelEdit.hidden = true;
  document.querySelector("#form-title").textContent = "Novo aluno";
}

function remove(id) {
  const student = students.find(item => item.id === id);
  if (!confirm(`Excluir o cadastro fictício de ${student.nome}?`)) return;
  students = students.filter(item => item.id !== id);
  persist(); render(); resetForm();
  message.textContent = "Aluno excluído.";
}

form.addEventListener("submit", event => {
  event.preventDefault();
  const data = {
    id: fields.id.value || crypto.randomUUID(),
    matricula: normalize(fields.matricula.value),
    nome: normalize(fields.nome.value),
    email: normalize(fields.email.value),
    situacao: fields.situacao.value
  };
  const duplicate = students.some(s => s.matricula === data.matricula && s.id !== data.id);
  if (duplicate) { message.textContent = "A matrícula já existe."; return; }
  const index = students.findIndex(s => s.id === data.id);
  if (index >= 0) students[index] = data; else students.push(data);
  persist(); render(); resetForm();
  message.textContent = index >= 0 ? "Aluno atualizado." : "Aluno cadastrado.";
});

search.addEventListener("input", render);
cancelEdit.addEventListener("click", resetForm);
render();
