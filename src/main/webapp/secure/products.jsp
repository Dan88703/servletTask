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
            box-sizing: border-box;
        }

        * { box-sizing: border-box; }

        html, body { margin: 0; min-height: 100%; }

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
            margin-bottom: 32px;
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

        .add-form fieldset {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: flex-start;
            border: none;
            margin: 0;
            padding: 0;
            width: 100%;
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

        .add-form input::placeholder { color: rgba(245, 243, 255, 0.35); }

        .add-form input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(168, 85, 247, 0.25);
        }

        .add-form input.invalid {
            border-color: #f87171;
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

        .add-btn:hover { transform: translateY(-2px); box-shadow: 0 12px 30px rgba(168, 85, 247, 0.45); }
        .add-btn:active { transform: translateY(0); }
        .add-btn:disabled { opacity: 0.6; cursor: not-allowed; transform: none; }

        .form-hint {
            width: 100%;
            font-size: 12px;
            color: #f87171;
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

        .empty.show { display: block; }

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
        }

        .product:hover {
            transform: translateY(-6px);
            border-color: rgba(168, 85, 247, 0.55);
            box-shadow: 0 26px 60px rgba(168, 85, 247, 0.25);
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

        @media (max-width: 520px) {
            header h1 { font-size: 26px; }
            body { padding-left: 16px; padding-right: 16px; }
            .add-btn-wrap { width: 100%; }
            .add-btn { width: 100%; }
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
        <fieldset>
            <div class="field">
                <label for="pname">Название продукта</label>
                <input name="name" type="text" id="pname" placeholder="Например: Наушники">
            </div>
            <div class="field">
                <label for="pimage">Ссылка на картинку</label>
                <input name="imgUrl" type="url" id="pimage" placeholder="https://...">
            </div>
            <div class="add-btn-wrap">
                <button type="submit" class="add-btn" id="addBtn">Добавить продукт</button>
            </div>
            <div class="form-hint" id="formHint"></div>
        </fieldset>
    </form>

    <div class="grid" id="grid">
        <c:forEach var="product" items="${products}">
            <div class="product">
                <div class="thumb">
                    <img src="${product.url}" alt="${product.name}" onerror="this.parentElement.textContent='📦'">
                </div>
                <h3><c:out value="${product.name}"/></h3>
            </div>
            <form action="/secure/products">
                <input type="hidden" name="_method" value="DELETE"/>
                <input type="hidden" name="id" value="${product.id}"/>
                <button type="submit" name="remove-btn" style="color: red">Remove</button>
            </form>
        </c:forEach>
    </div>

    <c:if test="${empty products}">
        <div class="empty show" id="empty">Пока нет ни одного продукта — добавь первый выше 👆</div>
    </c:if>
</div>

<script>
    const form = document.getElementById('addForm');
    const nameInput = document.getElementById('pname');
    const formHint = document.getElementById('formHint');
    const addBtn = document.getElementById('addBtn');

    form.addEventListener('submit', (e) => {
        e.preventDefault();

        const name = nameInput.value.trim();
        nameInput.classList.remove('invalid');

        if (!name) {
            nameInput.classList.add('invalid');
            formHint.textContent = 'Введите название продукта';
            return;
        }

        addBtn.disabled = true;
        formHint.textContent = '';

        fetch('/secure/products', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams(new FormData(form))
        }).then(res => {
            if (res.ok) {
                // Продукт сохранён на сервере — перезагружаем страницу,
                // чтобы JSP заново отрисовал актуальный список из products.json
                window.location.reload();
            } else {
                formHint.textContent = 'Ошибка при добавлении продукта';
                addBtn.disabled = false;
            }
        }).catch(() => {
            formHint.textContent = 'Не удалось связаться с сервером';
            addBtn.disabled = false;
        });
        fetch("/login", {}. then(res =>{
            if(res.ok){
                window.location.href = "/secure/products"
            }else {
                setHint(passHint, 'Ошибка при регистрации', 'error');
            }
        }))
    });
</script>

</body>
</html>
