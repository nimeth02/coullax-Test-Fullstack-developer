const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const Review = require('./db');


const app = express();

// Middleware
app.use(express.json());
app.use(cors());

// MongoDB Connection
mongoose.connect('mongodb://127.0.0.1:27017/book', {
}).then(() => console.log('MongoDB connected'))
  .catch(err => console.error('MongoDB connection error:', err));



// REST API Endpoints
app.get('/reviews', async (req, res) => {
  const reviews = await Review.find();
  res.json(reviews);
});

app.post('/reviews', async (req, res) => {
  const { title, author, rating, reviewText } = req.body;
  const newReview = new Review({ title, author, rating, reviewText });
  await newReview.save();
  res.status(201).json(newReview);
});

app.put('/reviews/:id', async (req, res) => {
  const { id } = req.params;
  const { title, author, rating, reviewText } = req.body;
  const updatedReview = await Review.findByIdAndUpdate(
    id,
    { title, author, rating, reviewText },
    { new: true }
  );
  res.status(200).json(updatedReview);
});

app.delete('/reviews/:id', async (req, res) => {
  const { id } = req.params;
  console.log(id,"delete"); 
  await Review.findByIdAndDelete(id);
  res.status(204).send();
});

// Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));