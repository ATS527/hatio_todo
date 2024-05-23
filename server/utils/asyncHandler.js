function asyncHandler(fn) {
    return async function (req, res) {
        return Promise
            .resolve(fn(req, res))
            .catch((err) => {
                console.log(err);
                res.status(500).json({
                    success: false,
                    message: "Internal server error"
                });
            });
    }
}

module.exports = asyncHandler;