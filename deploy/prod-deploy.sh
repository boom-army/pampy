read -p "***PRODUCTION DEPLOY*** Deploy UI to prod (y/n)?" CONT
if [ "$CONT" = "y" ]; then
    rm -rf ./dist
    cp .env.production .env
    yarn build
    aws s3 rm s3://boom.army --recursive
    aws s3 sync ./dist s3://boom.army
    cp .env.dev .env
    aws cloudfront create-invalidation --distribution-id E3ULLSCY1L385R --paths "/*"
else
    echo "Phew! Dodged a bullet.";
fi
