// Import necessary modules
const express = require('express');
const bodyParser = require('body-parser');

// Create an Express app
const app = express();
const port = 3000; // Choose any port you prefer

// Use bodyParser to parse incoming request bodies
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Sample in-memory data store for airplanes
let airplanes = [
    { id: 1, name: 'Airplane 1', model: 'Model 1' },
    { id: 2, name: 'Airplane 2', model: 'Model 2' }
];

// Route to get all airplanes
app.get('/airplanes', (req, res) => {
    res.json(airplanes);
});

// Route to add a new airplane
app.post('/airplanes', (req, res) => {
    const { name, model } = req.body;
    const newAirplane = { id: airplanes.length + 1, name, model };
    airplanes.push(newAirplane);
    res.json(newAirplane);
});

// Route to delete an airplane by ID
app.delete('/airplanes/:id', (req, res) => {
    const { id } = req.params;
    airplanes = airplanes.filter(airplane => airplane.id !== parseInt(id));
    res.json({ message: 'Airplane deleted successfully' });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
