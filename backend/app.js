const express = require("express");
const mysql = require('mysql2/promise');
const bodyParser = require("body-parser");
const cors = require("cors");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json());

const pool = mysql.createPool({
    host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

app.get('/restaurants', async (req, res) => {
    try {
        const [restaurants] = await pool.query('SELECT * FROM restaurants');
        
        if (!restaurants.length) {
            return res.json({ success: true, data: [] });
        }

        const restaurantData = await Promise.all(restaurants.map(async (restaurant) => {
            const [ratings] = await pool.query(
                'SELECT AVG(rating) AS avg_rating, COUNT(rating) AS rating_count FROM ratings WHERE restaurant_id = ?',
                [restaurant.id]
            );

            return {
                id: restaurant.id,
                name: restaurant.name,
                type: restaurant.type,
                image: restaurant.image,
                location: restaurant.location,
                avg_rating: parseFloat(ratings[0].avg_rating || 0).toFixed(2),
                rating_count: ratings[0].rating_count || 0
            };
        }));

        res.json({ success: true, data: restaurantData });
    } catch (error) {
        console.error('Error fetching restaurants:', error);
        res.status(500).json({ success: false, message: 'Internal server error' });
    }
});

app.get('/restaurant/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const [restaurantDetails] = await pool.query(
            'SELECT * FROM restaurants WHERE id = ?',
            [id]
        );

        if (!restaurantDetails.length) {
            return res.status(404).json({ success: false, message: 'Restaurant not found' });
        }

        const restaurant = restaurantDetails[0];

        const [menus] = await pool.query(
            'SELECT menu_name, price FROM menus WHERE restaurant_id = ?',
            [id]
        );

        const [ratings] = await pool.query(
            'SELECT AVG(rating) AS avg_rating, COUNT(rating) AS rating_count FROM ratings WHERE restaurant_id = ?',
            [id]
        );

        const avgRating = parseFloat(ratings[0].avg_rating || 0).toFixed(2);
        const ratingCount = ratings[0].rating_count || 0;

        const [reviews] = await pool.query(
            'SELECT user_name, comment FROM reviews WHERE restaurant_id = ?',
            [id]
        );

        const response = {
            success: true,
            data: {
                id: restaurant.id,
                name: restaurant.name,
                type: restaurant.type,
                location: restaurant.location,
                avg_rating: avgRating,
                rating_count: ratingCount,
                menus: menus.map(menu => ({
                    name: menu.menu_name,
                    price: menu.price
                })),
                reviews: reviews.map(review => ({
                    user: review.user_name,
                    comment: review.comment
                }))
            }
        };

        res.json(response);
    } catch (error) {
        console.error('Error fetching restaurant details:', error);
        res.status(500).json({ success: false, message: 'Internal server error' });
    }
});

app.post('/restaurant/:id/review', async (req, res) => {
    const { id } = req.params;
    const { rating, user_name, comment } = req.body;

    if (!rating || rating < 1 || rating > 5) {
        return res.status(400).json({ success: false, message: 'Invalid rating. Must be between 1 and 5.' });
    }

    if (!user_name || user_name.trim() === '') {
        return res.status(400).json({ success: false, message: 'User name is required.' });
    }

    if (!comment || comment.trim() === '') {
        return res.status(400).json({ success: false, message: 'Comment is required.' });
    }

    try {
        const [restaurant] = await pool.query('SELECT id FROM restaurants WHERE id = ?', [id]);
        if (!restaurant.length) {
            return res.status(404).json({ success: false, message: 'Restaurant not found.' });
        }

        await pool.query(
            'INSERT INTO ratings (restaurant_id, rating) VALUES (?, ?)',
            [id, rating]
        );

        await pool.query(
            'INSERT INTO reviews (restaurant_id, user_name, comment) VALUES (?, ?, ?)',
            [id, user_name, comment]
        );

        res.json({ success: true, message: 'Review and rating added successfully.' });
    } catch (error) {
        console.error('Error adding review and rating:', error);
        res.status(500).json({ success: false, message: 'Internal server error.' });
    }
});






app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
