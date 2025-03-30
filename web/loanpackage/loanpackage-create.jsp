<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Loan Package</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 flex items-center justify-center min-h-screen">
        <div class="bg-white p-6 rounded-lg shadow-md max-w-lg w-full">
            <h1 class="text-2xl font-bold text-center text-gray-700 mb-6">Create New Loan Package</h1>
            <form action="${pageContext.request.contextPath}/loanpackage/createloanpackage" method="post" class="space-y-4" onsubmit="return validateForm(event)">
                <div>
                    <label for="packageName" class="block text-gray-600 font-semibold">Package Name</label>
                    <input type="text" id="packageName" name="packageName" maxlength="100" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                    <p class="text-red-500 text-sm hidden" id="errorPackageName">Package name is required.</p>
                </div>

                <div>
                    <label for="loanType" class="block text-gray-600 font-semibold">Loan Type</label>
                    <input type="text" id="loanType" name="loanType" maxlength="50" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                    <p class="text-red-500 text-sm hidden" id="errorLoanType">Loan type is required.</p>
                </div>

                <div>
                    <label for="description" class="block text-gray-600 font-semibold">Description</label>
                    <textarea id="description" name="description" rows="4" maxlength="500" 
                              class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300"></textarea>
                    <p class="text-red-500 text-sm hidden" id="errorDescription">Description is required.</p>
                </div>

                <div>
                    <label for="interestRate" class="block text-gray-600 font-semibold">Interest Rate (%)</label>
                    <input type="number" step="0.01" id="interestRate" name="interestRate" min="0" max="100" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                    <p class="text-red-500 text-sm hidden" id="errorInterestRate">Interest rate is required.</p>
                </div>

                <div>
                    <label for="minAmount" class="block text-gray-600 font-semibold">Minimum Loan Amount</label>
                    <input type="text" id="minAmount" name="minAmount" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300" 
                           oninput="formatNumberInput(this)">
                    <p class="text-red-500 text-sm hidden" id="errorMinAmount">Minimum loan amount is required.</p>
                </div>

                <div>
                    <label for="maxAmount" class="block text-gray-600 font-semibold">Maximum Loan Amount</label>
                    <input type="text" id="maxAmount" name="maxAmount" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300" 
                           oninput="formatNumberInput(this)">
                    <p class="text-red-500 text-sm hidden" id="errorMaxAmount">Maximum loan amount is required.</p>
                </div>

                <div>
                    <label for="loanTerm" class="block text-gray-600 font-semibold">Loan Term (months)</label>
                    <input type="number" id="loanTerm" name="loanTerm" min="1" max="360" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                    <p class="text-red-500 text-sm hidden" id="errorLoanTerm">Loan term is required.</p>
                </div>

                <div class="flex space-x-4">
                    <button type="submit" class="w-full bg-green-500 text-white py-2 rounded-md hover:bg-green-600 transition">Create Loan Package</button>
                    <button type="button" onclick="window.location.href = 'loanpackage-list.jsp'" class="w-full bg-gray-500 text-white py-2 rounded-md hover:bg-gray-600 transition">Cancel</button>
                </div>
            </form>
        </div>
    </body>
    <script>
        function validateForm(event) {
            let isValid = true;
            let fields = ["packageName", "loanType", "description", "interestRate", "minAmount", "maxAmount", "loanTerm"];

            fields.forEach(field => {
                let input = document.getElementById(field);
                let error = document.getElementById("error" + field.charAt(0).toUpperCase() + field.slice(1));

                if (!input.value.trim()) {
                    error.classList.remove("hidden");
                    isValid = false;
                } else {
                    error.classList.add("hidden");
                }
            });

            if (!isValid) {
                event.preventDefault();
            }
            return isValid;
        }

        function formatNumberInput(input) {
            let value = input.value.replace(/\./g, ''); // Remove dots
            if (!isNaN(value) && value !== "") {
                input.value = parseFloat(value).toLocaleString("vi-VN");
            }
        }
    </script>
</html>
