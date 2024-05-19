window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (priceInput && addTaxDom && profitDom) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;

      // 入力が数値かどうかを確認
      if (!isNaN(inputValue) && inputValue.trim() !== "") {
        const inputNumber = parseFloat(inputValue);

        // 入力した金額をもとに販売手数料を計算する処理
        const tax = Math.floor(inputNumber * 0.1);
        addTaxDom.innerHTML = tax;

        // 出品価格から販売手数料を引く処理
        const profit = inputNumber - tax;
        profitDom.innerHTML = profit;
      } else {
        // 入力が数値でない場合、税と利益を0に設定
        addTaxDom.innerHTML = 0;
        profitDom.innerHTML = 0;
      }
    });
  } else {
    console.error("必要なDOM要素が見つかりません");
  }
});
