window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  function calculateAndDisplayTaxAndProfit() {
    const inputValue = priceInput.value;
    console.log("Input value:", inputValue);  // デバッグ用のログ

    // 入力が数値かどうかを確認
    if (!isNaN(inputValue) && inputValue.trim() !== "") {
      const inputNumber = parseFloat(inputValue);
      console.log("Input number:", inputNumber);  // デバッグ用のログ

      // 入力した金額をもとに販売手数料を計算する処理
      const tax = Math.floor(inputNumber * 0.1);
      addTaxDom.innerHTML = tax;
      console.log("Calculated tax:", tax);  // デバッグ用のログ

      // 出品価格から販売手数料を引く処理
      const profit = inputNumber - tax;
      profitDom.innerHTML = profit;
      console.log("Calculated profit:", profit);  // デバッグ用のログ
    } else {
      // 入力が数値でない場合、税と利益を0に設定
      addTaxDom.innerHTML = 0;
      profitDom.innerHTML = 0;
      console.log("Invalid input, tax and profit set to 0");  // デバッグ用のログ
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
});
