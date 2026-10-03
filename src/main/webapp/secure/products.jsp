<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <title>Мои продукты</title>
    <style>
        :root {
            --bg-1: #1e1b4b;
            --bg-2: #4c1d95;
            --accent: #a855f7;
            --accent-2: #6366f1;
            --card-bg: rgba(255, 255, 255, 0.08);
            --text: #f5f3ff;
            --text-dim: #c4b5fd;
            --error: #f87171;
            box-sizing: border-box;
        }

        * {
            box-sizing: border-box;
        }

        html, body {
            margin: 0;
            min-height: 100%;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: radial-gradient(circle at 20% 20%, var(--bg-2), var(--bg-1) 60%) fixed;
            color: var(--text);
            padding: calc(32px + env(safe-area-inset-top, 0px)) 24px calc(32px + env(safe-area-inset-bottom, 0px));
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
        }

        /* ---------- Шапка ---------- */
        header {
            text-align: center;
            margin-bottom: 28px;
        }

        header h1 {
            margin: 0;
            font-size: 34px;
            font-weight: 700;
            background: linear-gradient(90deg, #f472b6, var(--accent), var(--accent-2));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        header p {
            margin: 8px 0 0;
            color: var(--text-dim);
            font-size: 15px;
        }

        /* ---------- Форма добавления ---------- */
        .add-form {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: flex-start;
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 18px;
            padding: 20px;
            margin-bottom: 32px;
        }

        .add-form .field {
            flex: 1 1 220px;
        }

        .add-form label {
            display: block;
            font-size: 13px;
            color: var(--text-dim);
            margin-bottom: 6px;
            font-weight: 500;
        }

        .add-form input {
            width: 100%;
            padding: 12px 14px;
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            background: rgba(0, 0, 0, 0.25);
            color: var(--text);
            font-size: 15px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .add-form input::placeholder {
            color: rgba(245, 243, 255, 0.35);
        }

        .add-form input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(168, 85, 247, 0.25);
        }

        .add-form input.invalid {
            border-color: var(--error);
        }

        .add-btn-wrap {
            display: flex;
            align-items: flex-end;
        }

        .add-btn {
            padding: 12px 22px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(90deg, var(--accent-2), var(--accent));
            color: white;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            white-space: nowrap;
            box-shadow: 0 8px 24px rgba(168, 85, 247, 0.35);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(168, 85, 247, 0.45);
        }

        .add-btn:active {
            transform: translateY(0);
        }

        .form-hint {
            width: 100%;
            font-size: 12px;
            color: var(--error);
            min-height: 16px;
        }

        /* ---------- Сетка ---------- */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 22px;
        }

        .empty {
            display: none;
            text-align: center;
            padding: 60px 20px;
            color: var(--text-dim);
            font-size: 16px;
        }

        .empty.show {
            display: block;
        }

        .product {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 20px;
            padding: 22px;
            display: flex;
            flex-direction: column;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
            animation: fadeUp 0.45s ease both;
            position: relative;
        }

        .product:hover {
            transform: translateY(-6px);
            border-color: rgba(168, 85, 247, 0.55);
            box-shadow: 0 26px 60px rgba(168, 85, 247, 0.25);
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(14px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .thumb {
            height: 140px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            margin-bottom: 16px;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.35), rgba(168, 85, 247, 0.35));
            overflow: hidden;
        }

        .thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            word-break: break-word;
        }

        .remove {
            position: absolute;
            top: 14px;
            right: 14px;
            width: 26px;
            height: 26px;
            border-radius: 50%;
            border: none;
            background: rgba(0, 0, 0, 0.35);
            color: var(--text-dim);
            font-size: 14px;
            line-height: 1;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.2s ease, background 0.2s ease, color 0.2s ease;
        }

        .product:hover .remove {
            opacity: 1;
        }

        .remove:hover {
            background: var(--error);
            color: white;
        }

        @media (max-width: 520px) {
            header h1 {
                font-size: 26px;
            }

            body {
                padding-left: 16px;
                padding-right: 16px;
            }

            .add-btn-wrap {
                width: 100%;
            }

            .add-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <header>
        <h1>Мои продукты</h1>
        <p>Добавляй свои товары ниже</p>
    </header>

    <form class="add-form" action="/secure/products" method="post" id="addForm">
        <div class="field">
            <label for="pname">Название продукта</label>
            <input name="name" type="text" id="pname" placeholder="Например: Наушники">
        </div>
        <div class="field">
            <label for="pimage">Ссылка на картинку</label>
            <input name="imgUrl" type="url" id="pimage" placeholder="https://...">
        </div>
        <div class="add-btn-wrap">
            <button type="submit" class="add-btn">Добавить продукт</button>
        </div>
        <div class="form-hint" id="formHint"></div>
    </form>
        <c:forEach var="product" items="${products}">
            <div class="product">
                <div class="thumb">
           <img src="${product.imgUrl}">
                </div>
                <h3>
                    <c:out value="${product.name}"/>
                </h3>

            </div>
        </c:forEach>
    <div class="grid" id="grid"></div>
    <div class="empty" id="empty">Пока нет ни одного продукта — добавь первый выше 👆</div>
</div>

<script>
    // ---------- Начальный список (можно оставить пустым: []) ----------
    const products = [];

    const grid = document.getElementById('grid');
    const emptyEl = document.getElementById('empty');
    const form = document.getElementById('addForm');
    const nameInput = document.getElementById('pname');
    const imageInput = document.getElementById('pimage');
    const formHint = document.getElementById('formHint');

    function renderProducts() {
        grid.innerHTML = '';
        emptyEl.classList.toggle('show', products.length === 0);

        products.forEach((p, index) => {
            const card = document.createElement('div');
            card.className = 'product';
            card.style.animationDelay = (index * 0.05) + 's';

            const thumb = p.image
                ? `<img src="${p.image}" alt="${p.name}" onerror="this.parentElement.textContent='📦'">`
                : '📦';

            card.innerHTML = `
        <button class="remove" title="Удалить">✕</button>
        <div class="thumb">${thumb}</div>
        <h3>${p.name}</h3>
      `;

            card.querySelector('.remove').addEventListener('click', () => {
                products.splice(index, 1);
                renderProducts();
            });

            grid.appendChild(card);
        });
    }

    form.addEventListener('submit', (e) => {
        e.preventDefault();

        const name = nameInput.value.trim();
        const image = imageInput.value.trim();

        nameInput.classList.remove('invalid');

        if (!name) {
            nameInput.classList.add('invalid');
            formHint.textContent = 'Введите название продукта';
            return;
        }

        fetch('/secure/products', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: new URLSearchParams(new FormData(form))
        }).then(res => {
            if (res.ok) {
                formHint.textContent = '';
                // Отображение продуктов будет реализовано отдельно.
                // Успешный POST не добавляет карточку в интерфейс.

                form.reset();
                nameInput.focus();
            } else {
                formHint.textContent = 'Ошибка при добавлении продукта';
            }
        }).catch(() => {
            formHint.textContent = 'Не удалось связаться с сервером';
        });
    });

    renderProducts();
</script>

</body>
</html>