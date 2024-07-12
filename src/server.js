const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const mongoose = require('mongoose');
const path = require('path');

const app = express();
const port = 3000;

// Body parser middleware
app.use(bodyParser.urlencoded({ extended: true }));

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

// MongoDB setup (adjust URL and options as needed)
mongoose.connect('mongodb://localhost/myapp', { useNewUrlParser: true, useUnifiedTopology: true });
const db = mongoose.connection;
db.once('open', () => console.log('Connected to MongoDB'));

// User model
const User = require('./models/User'); // Define your User model in models/User.js

// Route to serve the index.html file
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Route to handle user registration
app.post('/register', (req, res) => {
    const { name, email, password } = req.body;

    // Validate form data (add more validation as needed)
    if (!name || !email || !password) {
        return res.status(400).send('Please fill in all fields');
    }

    // Check if user already exists
    User.findOne({ email: email })
        .then(user => {
            if (user) {
                return res.status(400).send('Email already registered');
            } else {
                // Create new user
                const newUser = new User({
                    name,
                    email,
                    password
                });

                // Hash password before saving to database
                bcrypt.genSalt(10, (err, salt) =>
                    bcrypt.hash(newUser.password, salt, (err, hash) => {
                        if (err) throw err;
                        // Set password to hashed
                        newUser.password = hash;
                        // Save user
                        newUser.save()
                            .then(user => {
                                res.redirect('/login'); // Redirect to login page after successful registration
                            })
                            .catch(err => console.log(err));
                    }));
            }
        })
        .catch(err => console.log(err));
});

// Start server
app.listen(port, () => console.log(`Server started on http://localhost:${port}`));
