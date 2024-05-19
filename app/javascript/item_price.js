const pay = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  function calculateAndDisplayTaxAndProfit() {
    const inputValue = priceInput.value;

    // 入力が数値かどうかを確認
    if (!isNaN(inputValue) && inputValue.trim() !== "") {
      const inputNumber = parseFloat(inputValue);

      // 入力した金額をもとに販売手数料を計算する処理
      const tax = Math.floor(inputNumber * 0.1);
      addTaxDom.innerHTML = tax;

      // 出品価格から販売手数料を引く処理
      const profit = Math.floor(inputNumber - tax);
      profitDom.innerHTML = profit;
     } else {
      // 入力が数値でない場合、税と利益を0に設定
      addTaxDom.innerHTML = 0;
      profitDom.innerHTML = 0;
    }
  }

  if (priceInput && addTaxDom && profitDom) {
    // ページがロードされたときに一度計算を実行
    calculateAndDisplayTaxAndProfit();

    // 入力が変わったときに計算を実行
    priceInput.addEventListener("input", calculateAndDisplayTaxAndProfit);
  } else {
    console.error("必要なDOM要素が見つかりません");
  }
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
