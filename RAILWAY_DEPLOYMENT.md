# Railway Deployment Guide for At Dawn, I Am

## Prerequisites
- Railway account
- GitHub repository with your code

## Deployment Steps

### 1. Set up Environment Variables in Railway
In your Railway project settings, add these environment variables:

```
RAILS_ENV=production
RAILS_MASTER_KEY=your_master_key_from_config/master.key
DATABASE_URL=postgresql://username:password@host:port/database_name
SECRET_KEY_BASE=your_secret_key_base
```

### 2. Database Setup
Railway will automatically create a PostgreSQL database for you. The app will run migrations on deploy.

### 3. Deploy to Railway
1. Connect your GitHub repository to Railway
2. Railway will automatically detect it's a Rails app
3. Set the build command: `bundle install && bin/rails db:prepare`
4. Set the start command: `bundle exec puma -C config/puma.rb`

### 4. Admin Access
After deployment:
1. Visit `your-app.railway.app/admin/login`
2. Enter your email address
3. In development mode, you'll see the magic link on screen
4. In production, you'll need to set up email (or temporarily show the link)

### 5. First Admin Setup
The first email you use becomes an admin account automatically.

## Mobile Admin Access
Once logged in, you can:
- Create new journal entries from your phone
- Edit existing entries
- Manage the about page
- Upload images

## Post-Deploy Checklist
- [ ] Set up proper email delivery for production magic links
- [ ] Configure custom domain if needed
- [ ] Test mobile admin functionality
- [ ] Verify image uploads work correctly

## Email Configuration (Optional)
For production magic links, add to your environment:
```
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_DOMAIN=gmail.com
SMTP_USER=your_email@gmail.com
SMTP_PASSWORD=your_app_password
```

## Security Notes
- The magic link tokens expire after 15 minutes
- Links become invalid after first use
- Admin sessions are stored securely in Rails sessions