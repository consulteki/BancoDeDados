const API_URL = "http://localhost:3000";

async function request(path, options = {}) {
  const response = await fetch(`${API_URL}${path}`, {
    headers: { "Content-Type": "application/json", ...options.headers },
    ...options
  });
  if (response.status === 204) return null;
  const body = await response.json().catch(() => ({}));
  if (!response.ok) throw new Error(body.error || body.errors?.join(", ") || `HTTP ${response.status}`);
  return body;
}

export const api = {
  listStudents: query => request(`/alunos?q=${encodeURIComponent(query || "")}`),
  createStudent: data => request("/alunos", { method: "POST", body: JSON.stringify(data) }),
  updateStudent: (id,data) => request(`/alunos/${id}`, { method: "PUT", body: JSON.stringify(data) }),
  deleteStudent: id => request(`/alunos/${id}`, { method: "DELETE" })
};
