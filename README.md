# At Dawn, I Am

A personal diary-style Ruby on Rails application that feels like reading pages from someone's private journal. Each entry contains one image and one body of reflective writing.

## Features

- **Diary Experience**: One image and one reflective writing per entry
- **Minimal Design**: Clean, reading-focused interface with Tailwind CSS
- **Mobile-First**: Beautiful on all devices
- **External Support**: Ko-fi links for support (no payments in-app)
- **Hotwire Powered**: Rails 7 with Turbo Drive, no custom JavaScript required

## Tech Stack

- Ruby on Rails 8.1.2
- PostgreSQL
- Active Storage for image uploads
- Tailwind CSS
- Hotwire (Turbo Drive)
- Deployed on Railway.app

## Getting Started

### Prerequisites

- Ruby 3.2.0+
- PostgreSQL
- Bundler

### Installation

1. Clone the repository
   ```bash
   git clone <repository-url>
   cd at_dawn_i_am
   ```

2. Install dependencies
   ```bash
   bundle install
   ```

3. Set up the database
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the development server
   ```bash
   bin/dev
   ```

5. Visit `http://localhost:3000`

### Development

The application includes sample diary entries seeded automatically when you run `rails db:seed`. These entries demonstrate the intended reading experience with thoughtful, reflective writing paired with images.

## Deployment

### Railway Deployment

1. Create a new project on Railway.app
2. Connect your GitHub repository
3. Set these environment variables:
   - `RAILS_MASTER_KEY`: Your Rails master key from `config/master.key`
   - `DATABASE_URL`: Provided automatically by Railway
   - `AWS_ACCESS_KEY_ID`: Your AWS access key for S3
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
   - `AWS_S3_BUCKET`: Your S3 bucket name
   - `AWS_REGION`: Your S3 bucket region (default: us-east-1)

4. Deploy - Railway will automatically detect the Rails application

## Philosophy

This application embodies simplicity and intimacy:

- **No categories or tags** - entries stand alone
- **No comments or likes** - this is a reading experience, not social media
- **No authentication** - simplicity over complexity
- **No analytics** - respect for reader privacy
- **One image, one story** - focus and intentionality

Each entry should feel like turning a page in someone's private diary - intimate, quiet, and deeply personal.

## License

MIT License
