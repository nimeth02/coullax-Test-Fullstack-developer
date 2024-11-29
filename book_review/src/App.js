import React, { useEffect, useState } from "react";
import axios from "axios";
import ListItem from './ListItem.js'

const App = () => {
  const [reviews, setReviews] = useState([]);
  const [formData, setFormData] = useState({
    title: "",
    author: "",
    rating: "",
    reviewText: "",
  });

  const [editingReview, setEditingReview] = useState(null);

  // Fetch reviews
  useEffect(() => {
    fetchReviews();
  }, []);

  const fetchReviews = async () => {
    const response = await axios.get("http://localhost:5000/reviews");
    setReviews(response.data);
  };

  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (editingReview) {
      await axios.put(`http://localhost:5000/reviews/${editingReview._id}`, formData);
      setEditingReview(null);
    } else {
      await axios.post("http://localhost:5000/reviews", formData);
    }
    setFormData({ title: "", author: "", rating: "", reviewText: "" });
    fetchReviews();
  };

  const handleEdit = (review) => {
    setEditingReview(review);
    setFormData(review);
  };

  const handleDelete = async (id) => {
    await axios.delete(`http://localhost:5000/reviews/${id}`);
    fetchReviews();
  };

  return (
    <div className="min-h-screen bg-gray-100 p-6">
      <div className="max-w-4xl mx-auto bg-white rounded-lg shadow-md p-8">
        <h1 className="text-3xl font-bold mb-6 text-center text-gray-800">Book Reviews</h1>

        {/* Review Form */}
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Book Title</label>
            <input
              type="text"
              name="title"
              className="mt-1 block w-full p-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500"
              placeholder="Book Title"
              value={formData.title}
              onChange={handleInputChange}
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">Author</label>
            <input
              type="text"
              name="author"
              className="mt-1 block w-full p-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500"
              placeholder="Author"
              value={formData.author}
              onChange={handleInputChange}
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">Rating (1-5)</label>
            <input
              type="number"
              name="rating"
              className="mt-1 block w-full p-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500"
              placeholder="Rating (1-5)"
              value={formData.rating}
              onChange={handleInputChange}
              min="1"
              max="5"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">Your Review</label>
            <textarea
              name="reviewText"
              className="mt-1 block w-full p-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500"
              placeholder="Your Review"
              value={formData.reviewText}
              onChange={handleInputChange}
              required
            ></textarea>
          </div>

          <button
            type="submit"
            className="w-full bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600"
          >
            {editingReview ? "Update Review" : "Add Review"}
          </button>
        </form>

        {/* Reviews List */}
        <div className="mt-8">
          <h2 className="text-2xl font-bold mb-4 text-gray-800">All Reviews</h2>
          {reviews.length === 0 ? (
            <p className="text-gray-500">No reviews found.</p>
          ) : (
            <ul className="space-y-4">
              {reviews.map((review) => (
                <ListItem review={review} handleEdit={handleEdit} handleDelete={handleDelete}/>
              ))}
            </ul>
          )}
        </div>
      </div>
    </div>
  );
};

export default App;