// Import thư viện lodash
import _ from 'lodash'

import { 
    createData,
    total_product
} from "./data.js";


// Hàm tính toán sự tương đồng cosine giữa hai người dùng
function cosineSimilarity(user1, user2, data, totalProductCount) {
    console.log(`=============user_id:${user2}================`);
    // Lấy danh sách sản phẩm mà cả hai người dùng đều đã mua
    const user1Products = data.filter(entry => entry.user_id === user1).map(entry => entry.product_id);
    const user2Products = data.filter(entry => entry.user_id === user2).map(entry => entry.product_id);
    console.log(`user ${user1} Products`,user1Products);
    console.log(`user ${user2} Products`,user2Products);
    // Tính vector của mỗi người dùng
    const user1Vector = _.range(1, totalProductCount+1).map(product_id => user1Products.includes(product_id) ? 1 : 0);
    const user2Vector = _.range(1, totalProductCount+1).map(product_id => user2Products.includes(product_id) ? 1 : 0);
    console.log(`Vector user ${user1} `,user1Vector);
    console.log(`Vector user ${user2} `,user2Vector);
    // Tính toán cosine similarity
    const dotProduct = _.sum(_.zip(user1Vector, user2Vector).map(([a, b]) => a * b));
    console.log(`dotProduct`,dotProduct);
    if (dotProduct==0) return dotProduct;
    const magnitudeUser1 = Math.sqrt(_.sum(user1Vector.map(val => val * val)));
    const magnitudeUser2 = Math.sqrt(_.sum(user2Vector.map(val => val * val)));
    console.log(`magnitudeUser1`,magnitudeUser1);
    console.log(`magnitudeUser2`,magnitudeUser2);
    console.log(`dotProduct / (magnitudeUser1 * magnitudeUser2)`,dotProduct / (magnitudeUser1 * magnitudeUser2));
    return dotProduct / (magnitudeUser1 * magnitudeUser2);
}
function recommendProducts(user, data, totalProductCount) {
    // Tính toán sự tương đồng giữa người dùng cụ thể và tất cả người dùng còn lại
    const similarities = [];
    for (let i = 0; i < _.max(data.map(entry => entry.user_id)) + 1; i++) {
        const checkBuy = data.filter(entry => entry.user_id === i).map(entry => entry.product_id);
        if (i !== user && checkBuy.length!==0) {
            similarities.push({
                user_id: i,
                similarity: cosineSimilarity(user, i, data, totalProductCount)
            });
        }
    }
    // Sắp xếp các người dùng khác theo sự tương đồng giảm dần
    const sortedSimilarities = similarities.sort((a, b) => b.similarity - a.similarity);
    console.log(`sortedSimilarities`,sortedSimilarities);
    // Lấy lịch sử mua hàng của người dùng cụ thể
    const userProducts = data.filter(entry => entry.user_id === user).map(entry => entry.product_id);
    // Tạo một tập hợp chứa tất cả các product_id đã mua bởi các người dùng có sự tương đồng cao
    const similarUsersProducts = new Set();
    for (let i = 0; i < sortedSimilarities.length; i++) {
        const similarUser = sortedSimilarities[i].user_id;
        if (similarUser !== user) {
            const similarUserProducts = data.filter(entry => entry.user_id === similarUser).map(entry => entry.product_id);
            similarUserProducts.forEach(product => similarUsersProducts.add(product));
        }
    }
    // Lọc ra các product_id mà người dùng cụ thể chưa mua nhưng đã được mua bởi các người dùng có sự tương đồng cao
    const recommended = Array.from(similarUsersProducts).filter(product => !userProducts.includes(product));
    const recommendedProducts = recommended.slice(0,8);
    return recommendedProducts;
}

export const recommended = (req, res) => { 
    const user = parseInt(req.params.id, 10);
    console.log(`user: '${user}'`);
   
    total_product((err, totalProductResult) => {
        if (err) {
            console.error("Error fetching total product count:", err);
            res.status(500).json({ error: "Internal server error" });
            return;
        }
        const totalProductCount = totalProductResult.total_product;
        console.log("total: ",totalProductCount)
 
        createData((err, dataResult) => {
            if (err) {
                console.error("Error fetching data from database:", err);
                res.status(500).json({ error: "Internal server error" });
                return;
            }

            const recommendations = recommendProducts(user, dataResult, totalProductCount);
        
            res.json(recommendations);
        });
    });
}