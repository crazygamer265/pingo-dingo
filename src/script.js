function validateForm(event) {
    event.preventDefault(); // Prevent the form from submitting by default

    // Fetching input values
    var firstName = document.getElementById('firstName').value.trim();
    var lastName = document.getElementById('lastName').value.trim();
    var email = document.getElementById('email').value.trim();
    var dob = document.getElementById('dob').value.trim();
    var gender = document.getElementById('gender').value.trim();
    var shirtSize = document.getElementById('shirtSize').value.trim();

    // Basic validation
    if (firstName === '' || lastName === '' || email === '' || dob === '' || gender === '' || shirtSize === '') {
        alert('Please fill in all fields');
        return;
    }

    // Further validation if needed (e.g., email format)

    // If all validations pass, you can submit the form (in this example, just an alert)
    alert('Form submitted successfully!');
}
