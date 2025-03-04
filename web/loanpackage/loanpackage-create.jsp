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
            <form action="createloanpackage" method="post" class="space-y-4">
                <div>
                    <label for="packageName" class="block text-gray-600 font-semibold">Package Name</label>
                    <input type="text" id="packageName" name="packageName" required maxlength="100" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                </div>

                <div>
                    <label for="loanType" class="block text-gray-600 font-semibold">Loan Type</label>
                    <input type="text" id="loanType" name="loanType" required maxlength="50" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                </div>

                <div>
                    <label for="description" class="block text-gray-600 font-semibold">Description</label>
                    <textarea id="description" name="description" rows="4" required maxlength="500" 
                              class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300"></textarea>
                </div>

                <div>
                    <label for="interestRate" class="block text-gray-600 font-semibold">Interest Rate (%)</label>
                    <input type="number" step="0.01" id="interestRate" name="interestRate" required min="0" max="100" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                </div>

                <div>
                    <label for="maxAmount" class="block text-gray-600 font-semibold">Maximum Loan Amount</label>
                    <input type="number" step="0.01" id="maxAmount" name="maxAmount" required min="0" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                </div>

                <div>
                    <label for="minAmount" class="block text-gray-600 font-semibold">Minimum Loan Amount</label>
                    <input type="number" step="0.01" id="minAmount" name="minAmount" required min="0" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                </div>

                <div>
                    <label for="loanTerm" class="block text-gray-600 font-semibold">Loan Term (months)</label>
                    <input type="number" id="loanTerm" name="loanTerm" required min="1" max="360" 
                           class="w-full px-4 py-2 border rounded-md focus:ring focus:ring-blue-300">
                </div>

                <button type="submit" class="w-full bg-green-500 text-white py-2 rounded-md hover:bg-green-600 transition">Create Loan Package</button>
            </form>
        </div>
    </body>
</html>