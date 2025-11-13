const hamburger = document.getElementById('hamburger');
const navMenu = document.querySelector('nav ul');
hamburger.addEventListener('click', () => {
  navMenu.classList.toggle('show');
});

const modal = document.getElementById('modal');
const modalText = document.getElementById('modal-text');
const closeBtn = document.querySelector('.close');

document.querySelectorAll('.learn-more').forEach(btn => {
  btn.addEventListener('click', () => {
    modalText.textContent = btn.dataset.info;
    modal.style.display = 'block';
  });
});

closeBtn.addEventListener('click', () => modal.style.display = 'none');
window.addEventListener('click', e => {
  if (e.target === modal) modal.style.display = 'none';
});

const themeToggle = document.getElementById('theme-toggle');
const body = document.body;

if (localStorage.getItem('theme') === 'dark') {
  body.classList.add('dark-mode');
  themeToggle.textContent = '☀️';
}

themeToggle.addEventListener('click', () => {
  const isDark = body.classList.toggle('dark-mode');
  themeToggle.textContent = isDark ? '☀️' : '🌙';
  localStorage.setItem('theme', isDark ? 'dark' : 'light');
});

const form = document.getElementById('contact-form');
const formMsg = document.getElementById('form-message');

form.addEventListener('submit', (e) => {
  e.preventDefault();
  
  const name = form.name.value.trim();
  const email = form.email.value.trim();
  const message = form.message.value.trim();

  let isValid = true;
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  form.querySelectorAll('input, textarea').forEach(el => el.classList.remove('error'));
  formMsg.textContent = '';

  if (!name) {
    form.name.classList.add('error');
    isValid = false;
  }
  if (!email || !emailRegex.test(email)) {
    form.email.classList.add('error');
    isValid = false;
  }
  if (!message) {
    form.message.classList.add('error');
    isValid = false;
  }

  if (!isValid) {
    formMsg.textContent = 'Lūdzu aizpildi visus laukus korekti!';
    formMsg.style.color = '#dc2626';
    formMsg.style.opacity = '1';
    return;
  }

  formMsg.textContent = 'Forma veiksmīgi iesniegta!';
  formMsg.style.color = '#16a34a';
  formMsg.style.opacity = '1';
  form.reset();
});

const searchInput = document.getElementById('search');
const cards = document.querySelectorAll('.card');

searchInput.addEventListener('input', () => {
  const term = searchInput.value.toLowerCase();

  cards.forEach(card => {
    const title = card.querySelector('.card-title').textContent.toLowerCase();
    const desc = card.querySelector('.card-desc').textContent.toLowerCase();
    if (title.includes(term) || desc.includes(term)) {
      card.style.display = 'block';
    } else {
      card.style.display = 'none';
    }
  });
});

const cardsContainer = document.querySelector('.cards-container');
const createForm = document.getElementById('create-card-form');
const titleInput = document.getElementById('new-title');
const descInput = document.getElementById('new-desc');
const imgInput = document.getElementById('new-img');

let cardsData = JSON.parse(localStorage.getItem('cards')) || [];

function renderCards() {
  cardsContainer.innerHTML = '';
  cardsData.forEach((card, index) => {
    const cardEl = document.createElement('div');
    cardEl.classList.add('card');
    cardEl.innerHTML = `
      <img src="${card.img}" alt="${card.title}">
      <div class="card-content">
        <h4 class="card-title">${card.title}</h4>
        <p class="card-desc">${card.desc}</p>
        <div class="card-actions">
          <button class="edit-btn" data-index="${index}">Labot</button>
          <button class="delete-btn" data-index="${index}">Dzēst</button>
        </div>
      </div>
    `;
    cardsContainer.appendChild(cardEl);
  });

  attachActionListeners();
}

function saveCards() {
  localStorage.setItem('cards', JSON.stringify(cardsData));
}

createForm.addEventListener('submit', (e) => {
  e.preventDefault();

  const newCard = {
    title: titleInput.value.trim(),
    desc: descInput.value.trim(),
    img: imgInput.value.trim()
  };

  if (!newCard.title || !newCard.desc || !newCard.img) return;

  cardsData.push(newCard);
  saveCards();
  renderCards();
  createForm.reset();
});

function attachActionListeners() {
  document.querySelectorAll('.delete-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const index = btn.dataset.index;
      cardsData.splice(index, 1);
      saveCards();
      renderCards();
    });
  });

  document.querySelectorAll('.edit-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const index = btn.dataset.index;
      const card = cardsData[index];

      const newTitle = prompt('Jauns nosaukums:', card.title);
      const newDesc = prompt('Jauns apraksts:', card.desc);
      const newImg = prompt('Jauns attēla URL:', card.img);

      if (newTitle && newDesc && newImg) {
        cardsData[index] = { title: newTitle, desc: newDesc, img: newImg };
        saveCards();
        renderCards();
      }
    });
  });
}

renderCards();