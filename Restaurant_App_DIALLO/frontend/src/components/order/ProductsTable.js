import React, { useState, useEffect } from "react";
import { useSelector, useDispatch } from "react-redux";

/* components */
import LoaderHandler from "../loader/LoaderHandler";
import Search from "../Search";
import { BigSpin } from "../loader/SvgLoaders";
import Pagination from "../Pagination";

/* actions */
import { listProducts } from "../../actions/productActions";

// Images statiques du menu (6 images pour les plats)
const menuImages = [
    "/assets/images/menu/menu1.png",
    "/assets/images/menu/menu2.png",
    "/assets/images/menu/menu3.png",
    "/assets/images/menu/menu4.png",
    "/assets/images/menu/menu5.png",
    "/assets/images/menu/menu6.png",
];

// Attribue une image selon l'id du produit (rotation cyclique)
const getMenuImage = (productId) => menuImages[(productId - 1) % menuImages.length];


const ProductsTable = ({
    productsInOrder,
    setProductsInOrder,
    productsAlreadyOrdered,
}) => {
    //add product to order
    const dispatch = useDispatch();
    const [keyword, setKeyword] = useState("");
    const [pageNumber, setPageNumber] = useState(0);
    const [products, setProducts] = useState([]);

    const addProduct = (e, product) => {
        e.preventDefault();

        //product object
        const productIn = {
            id: product.id,
            name: product.name,
            price: product.price,
            stock: product.stock,
            quantity: 1,
        };
        //if is already in order
        if (!inOrder(productIn, productsInOrder)) {
            setProductsInOrder([...productsInOrder, productIn]);
        } else {
            alert("Produit déjà en commande");
        }
    };

    //product list state
    const productList = useSelector((state) => state.productList);
    const {
        loading: loadingProductList,
        error: errorProductList,
        products: productsFromState,
        page,
        pages,
    } = productList;

    useEffect(() => {
        dispatch(listProducts(keyword, pageNumber));
    }, [keyword, pageNumber]);

    useEffect(() => {
        if (productsFromState) {
            setProducts(mapProducts(productsFromState));
        }
    }, [productsFromState]);

    //check if product is already in order
    const inOrder = (obj, list) => {
        for (let index = 0; index < list.length; index++) {
            if (obj.id === list[index].id) {
                return list[index];
            }
        }
        return false;
    };

    //refresh products table
    const refreshProducts = (e) => {
        e.preventDefault();
        dispatch(listProducts(keyword, pageNumber));
    };

    //check stock to show
    const showStock = (product) => {
        const productInOrder = productsInOrder.find(
            (productIn) => productIn.id === product.id
        );
        if (productInOrder) return product.stock - productInOrder.quantity;
        return product.stock;
    };

    const mapProducts = (productsToMap) => {
        if (!productsAlreadyOrdered) return productsToMap;

        const mappedProducts = productsToMap.map((item) => {
            productsAlreadyOrdered.map((item2) => {
                if (item.id === item2.id) {
                    item.stock = item.stock + item2.quantity;
                }
            });
            return item;
        });
        return mappedProducts;
    };

    const renderRefreshButton = () => (
        <button className="btn btn-info float-right" onClick={refreshProducts}>
            <i className="bi bi-arrow-clockwise">ACTUALISER</i>
        </button>
    );

    const renderProducts = () => (
        <div style={{ display: "flex", flexWrap: "wrap", gap: "16px", padding: "8px 0" }}>
            {products.map((product) => (
                <div key={product.id} style={{
                    width: "180px",
                    borderRadius: "12px",
                    boxShadow: "0 2px 10px rgba(0,0,0,0.12)",
                    overflow: "hidden",
                    background: "#fff",
                    display: "flex",
                    flexDirection: "column",
                    transition: "transform 0.2s",
                }}>
                    <div style={{ height: "120px", overflow: "hidden", background: "#f5f0e8" }}>
                        <img
                            src={getMenuImage(product.id)}
                            alt={product.name}
                            style={{ width: "100%", height: "100%", objectFit: "cover" }}
                            onError={(e) => { e.target.src = "/assets/images/menu/menu1.png"; }}
                        />
                    </div>
                    <div style={{ padding: "10px", flexGrow: 1, display: "flex", flexDirection: "column", gap: "4px" }}>
                        <strong style={{ fontSize: "0.9rem", color: "#3d2005" }}>{product.name}</strong>
                        <span style={{ color: "#c0392b", fontWeight: "700", fontSize: "0.85rem" }}>{product.price} FCFA</span>
                        <span style={{ fontSize: "0.75rem", color: showStock(product) > 0 ? "#27ae60" : "#e74c3c" }}>
                            {showStock(product) > 0 ? `Stock: ${showStock(product)}` : "Rupture"}
                        </span>
                    </div>
                    <div style={{ padding: "0 10px 10px" }}>
                        {inOrder(product, productsInOrder) ? (
                            <button disabled className="btn btn-primary btn-sm w-100">En cours</button>
                        ) : product.stock > 0 ? (
                            <button
                                className="btn btn-success btn-sm w-100"
                                onClick={(e) => addProduct(e, product)}
                            >
                                <i className="bi bi-plus-circle-fill"></i> Ajouter
                            </button>
                        ) : (
                            <button disabled className="btn btn-danger btn-sm w-100">Rupture</button>
                        )}
                    </div>
                </div>
            ))}
        </div>
    );

    return (
        <>
            <div class="pull-right mb-2">
                {renderRefreshButton()}

            </div>
            <Search
                keyword={keyword}
                setKeyword={setKeyword}
                setPage={setPageNumber}
            />
            <LoaderHandler
                loading={loadingProductList}
                error={errorProductList}
                render={renderProducts}
                loader={<BigSpin />}
            />

            <Pagination pages={pages} page={page} setPage={setPageNumber} />


        </>
    );
};

export default ProductsTable;
