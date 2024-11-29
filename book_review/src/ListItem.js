
const ListItem = ({review,handleEdit,handleDelete}) => {

  return (
                <li
                  key={review._id}
                  className="p-4 border border-gray-300 rounded-lg shadow-sm bg-gray-50"
                >
                  <div className="flex justify-between items-center">
                    <div>
                      <h3 className="text-xl font-semibold text-gray-800">{review.title}</h3>
                      <p className="text-sm text-gray-600">
                        by {review.author} - {review.rating} stars
                      </p>
                    </div>
                    <div className="flex space-x-2">
                      <button
                        onClick={() => handleEdit(review)}
                        className="px-3 py-1 bg-green-500 text-white rounded-lg hover:bg-green-600"
                      >
                        Edit
                      </button>
                      <button
                        onClick={() => handleDelete(review._id)}
                        className="px-3 py-1 bg-red-500 text-white rounded-lg hover:bg-red-600"
                      >
                        Delete
                      </button>
                    </div>
                  </div>
                  <p className="text-gray-700 mt-2">{review.reviewText}</p>
                </li>
              
  );
};

export default  ListItem